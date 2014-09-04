# Copyright 2013-2014 University of Technology, Sydney (github.com/uts)

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'ostruct'

module Reporta
  module Column
    extend ActiveSupport::Concern

    included do
      cattr_accessor :columns
      self.columns = {}
    end

    module ClassMethods
      def column(name, options={})
        columns[name] = OpenStruct.new options.reverse_merge(
          title: name.to_s.humanize
        )
      end
    end

    def value_for(record, column_name)
      column = columns[column_name]

      # Local method defined that matches the column name
      if respond_to? column_name
        self.send column_name, record

      # Column has the data_chain option set
      elsif column.data_chain
        data_chain_result(record, column.data_chain)

      # Call the column name method on the record
      else
        record.send column_name
      end
    end

    private

    def data_chain_result(record, data_chain)
      data_chain = data_chain.to_s.split '.'
      data_chain.reduce(record) do |obj, method|
        obj.send method
      end
    end

  end
end

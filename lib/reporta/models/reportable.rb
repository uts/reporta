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

module Reporta
  module Reportable
    extend ActiveSupport::Concern
    include Filter
    include Column

    attr_accessor :form

    def initialize(args={})
      args ||= {}
      @form = Reporta::Form.new filters, args
      form.valid? if args.present?
    end

    def id
      self.class.name.underscore
    end

    private

    # Delegate any undefined message to the @form object.
    # This allows you to call `report.start_date` to get the value of the
    # `start_date` filter or assign a value using
    # `report.start_date = '2013-01-01'`
    def method_missing(*args, &block)
      self.form.send(*args, &block)
    end
  end
end

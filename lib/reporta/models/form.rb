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
  class Form
    include ActiveModel::Validations
    include ActiveModel::Conversion

    attr_accessor :filters, :filter_applied, :params

    validate do
      filters.each do |name, options|
        if options.required && send(name).blank?
          # TODO: Allow for internationization of form validation errors
          errors.add(name, "required")
        end
      end
    end

    def initialize(filters, values={})
      @filters = filters
      @params = values
      self.class.send :attr_accessor, *filters.keys
      self.filter_applied = values.any?
      set_values filters, values
    end

    def filter_applied?
      self.filter_applied
    end

    # This method is required so a Form instance can be passed into a form_for
    # helper method
    def persisted?
      false
    end

    private

    def set_values(filters, values)
      filters.each do |name, filter|
        value = values[name].present? ? values[name] : filter.default
        value = convert_boolean(values[name]) if filter.boolean?

        self.send "#{name}=", value
      end
    end

    def convert_boolean(value)
      if value == "0"
        false
      elsif value == "1"
        true
      else
        !!value
      end
    end
  end
end

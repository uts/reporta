module Reporta
  class Form
    include ActiveModel::Validations
    include ActiveModel::Conversion

    attr_accessor :filters

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
      self.class.send :attr_accessor, *filters.keys
      set_values filters, values
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

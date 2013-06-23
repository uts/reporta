module Reporta
  class Form
    include ActiveModel::Validations
    include ActiveModel::Conversion

    attr_accessor :filters

    validate do
      filters.each do |name, options|
        if options.required && send(name).blank?
          errors.add(name, "required")
        end
      end
    end

    def initialize(filters)
      @filters = filters
      self.class.send :attr_accessor, *filters.keys
    end

    def persisted?
      false
    end
  end
end

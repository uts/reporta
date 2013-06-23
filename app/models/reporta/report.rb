module Reporta
  module Report
    extend ActiveSupport::Concern
    include Filter
    include Column

    attr_accessor :form

    def initialize(args={})
      args ||= {}
      @form = Reporta::Form.new filters
      set_form_values(args)
      form.valid? if args.present?
    end

    private

    def set_form_values(args)
      filters.each do |name, value|
        value = filter_value(args, name)
        value = convert_boolean(name, value) if filters[name].boolean?

        form.send "#{name}=", value
      end
    end

    # TODO: Please fix me.
    def convert_boolean(name, value)
      if value == "0"
        false
      elsif value == "1"
        true
      end
    end

    def method_missing(*args, &block)
      self.form.send(*args, &block)
    end
  end
end

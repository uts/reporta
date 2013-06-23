require 'ostruct'

module Reporta
  module Filter
    extend ActiveSupport::Concern

    attr_accessor :form

    included do
      cattr_accessor :filters
      self.filters = {}
    end

    module ClassMethods
      def filter(name, options={})
        filters[name] = OpenStruct.new(options.reverse_merge!({
          include_blank: options[:include_blank].nil?,
          name: options[:name].to_s.humanize
        }))
      end
    end

    def initialize(args={})
      args ||= {}
      @form = Reporta::Form.new filters
      set_form_values(args)
    end

    private
    def set_form_values(args)
      filters.each do |name, value|
        value = filter_value(args, name)
        value = convert_boolean(name, value) if filters[name].as == :boolean

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

    def filter_value(args, name)
      val = if args[name].present?
        args[name]
      else
        filters[name.to_sym].default
      end
    end

    def method_missing(*args, &block)
      self.form.send(*args, &block)
    end
  end
end

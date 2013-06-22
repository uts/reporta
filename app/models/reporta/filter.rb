module Reporta
  module Filter
    extend ActiveSupport::Concern

    attr_accessor :form

    included do
      cattr_accessor :all_filters
      self.all_filters = {}
    end

    module ClassMethods
      def filter(name, options={})
        options.reverse_merge!({
          include_blank: options[:include_blank].nil?,
          name: options[:name].to_s.humanize
        })

        all_filters[name] = OpenStruct.new(options)
      end
    end

    def initialize(args={})
      args ||= {}
      @form = Reporta::Form.new all_filters
      set_form_values(args)
    end

    def filters
      all_filters
    end

    private
    def set_form_values(args)
      all_filters.each do |name, value|
        val = if args[name].present?
          args[name]
        else
          all_filters[name.to_sym].default
        end

        # TODO: Please fix me.
        if all_filters[name.to_sym].as == :boolean
          if val == "0"
            val = false
          elsif val == "1"
            val = true
          end
        end

        form.send "#{name}=", val
      end
    end

    def method_missing(*args, &block)
      self.form.send(*args, &block)
    end
  end
end

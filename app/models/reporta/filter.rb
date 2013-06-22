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
        report_filter = OpenStruct.new(options)
        all_filters[name] = report_filter
      end
    end

    def initialize(args={})
      args ||= {}
      @form = Reporta::Form.new all_filters
      all_filters.each do |name, value|
        val = if args[name].present?
          args[name]
        else
          all_filters[name.to_sym].default
        end
        form.send "#{name}=", val
      end
    end

    def filters
      all_filters
    end

  end
end

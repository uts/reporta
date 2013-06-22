module Reporta
  module Filter
    extend ActiveSupport::Concern

    included do
      cattr_accessor :all_filters
      self.all_filters = {}
    end

    module ClassMethods
      def filter(name, options={})
        report_filter = OpenStruct.new(options)
        report_filter[:include_blank] = report_filter[:include_blank].nil?
        report_filter[:name] ||= name.to_s.humanize

        all_filters[name] = report_filter
      end
    end

    def filters
      all_filters
    end

    def initialize(args={})
      self.all_filters.each do |name, options|
        # self.form.class.send(:define_method, name) do
        #   instance_variable_get("@#{name}")
        # end

        # self.form.class.send(:define_method, "#{name}=") do
        #   instance_variable_set("@#{name}", args[name])
        # end
      end
    end

  end
end

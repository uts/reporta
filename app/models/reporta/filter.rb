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
        report_filter[:include_blank] ||= true
        report_filter[:name] ||= name.to_s.humanize

        all_filters[name] = report_filter
      end
    end

    def filters
      all_filters
    end
  end
end

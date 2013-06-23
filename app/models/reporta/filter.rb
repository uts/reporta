require 'ostruct'

module Reporta
  module Filter
    extend ActiveSupport::Concern

    included do
      cattr_accessor :filters
      self.filters = {}
    end

    module ClassMethods
      def filter(name, options={})
        filters[name] = OpenStruct.new(options.reverse_merge!({
          include_blank: options[:include_blank].nil?,
          name: options[:name].to_s.humanize,
          'boolean?' => (options[:as] == :boolean)
        }))
      end
    end

    private

    def filter_value(args, name)
      val = if args[name].present?
        args[name]
      else
        filters[name.to_sym].default
      end
    end
  end
end

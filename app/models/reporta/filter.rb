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
          name: options[:name].to_s.humanize,
          include_blank: options[:include_blank].nil?,
          'boolean?' => (options[:as] == :boolean)
        }))
      end
    end
  end
end

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
        filters[name] = OpenStruct.new options.reverse_merge(
          include_blank: true,
          'boolean?' => (options[:as] == :boolean)
        )
      end
    end
  end
end

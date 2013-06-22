module Reporta
  module Column
    extend ActiveSupport::Concern

    class ColumnData
      attr_accessor :name, :title, :class_names

      def initialize(name, args = {})
        @name = name
        @title = args.fetch(:title, name.to_s.humanize)
        @class_names = args.fetch(:class_names, '')
      end

      def value(record)
      end
    end

    included do
      cattr_accessor :all_columns
      self.all_columns = {}
    end

    module ClassMethods
      def column(name, args = {})
        all_columns[name] = ColumnData.new(name, args)
      end
    end

    def columns
      all_columns
    end

  end
end

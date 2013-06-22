require 'ostruct'

module Reporta
  module Column
    extend ActiveSupport::Concern

    included do
      cattr_accessor :all_columns
      self.all_columns = {}
    end

    module ClassMethods
      def column(name, args = {})
        args[:title] ||= name.to_s.humanize
        args[:class_names] ||= ''
        all_columns[name] = OpenStruct.new(args)
      end
    end

    def value_for(record, column_name)
      if respond_to? column_name
        self.send column_name, record
      else
        record.send column_name
      end
    end

    def columns
      all_columns
    end

  end
end

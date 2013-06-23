require 'ostruct'

module Reporta
  module Column
    extend ActiveSupport::Concern

    included do
      cattr_accessor :columns
      self.columns = {}
    end

    module ClassMethods
      def column(name, args = {})
        args[:title] ||= name.to_s.humanize
        args[:class_names] ||= ''
        columns[name] = OpenStruct.new(args)
      end
    end

    def value_for(record, column_name)
      if respond_to? column_name
        self.send column_name, record
      else
        record.send column_name
      end
    end

  end
end

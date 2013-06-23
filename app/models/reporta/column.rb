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
      column = columns[column_name]
      if respond_to? column_name
        self.send column_name, record
      elsif column.data_chain
        data_chain_result(record, column.data_chain)
      else
        record.send column_name
      end
    end

    private

    def data_chain_result(record, data_chain)
      data_chain = data_chain.to_s.split '.'
      data_chain.reduce(record) do |obj, method|
        obj.send method
      end
    end

  end
end

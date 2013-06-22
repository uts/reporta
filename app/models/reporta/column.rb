module Reporta
  module Column
    extend ActiveSupport::Concern
    Struct.new 'ReportColumn', :column_name, :title

    included do
      cattr_accessor :all_columns
      self.all_columns = {}
    end

    module ClassMethods
      def column(name, args = {})
        all_columns[name] = Struct::ReportColumn.new(name, args.fetch(:title, name))
      end
    end

    def columns
      all_columns
    end

  end
end

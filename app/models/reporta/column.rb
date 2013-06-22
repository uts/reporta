module Reporta
  module Column
    extend ActiveSupport::Concern
    Struct.new 'ReportColumn', :column_name, :title, :class_names

    included do
      cattr_accessor :all_columns
      self.all_columns = {}
    end

    module ClassMethods
      def column(name, args = {})
        title = args.fetch(:title, name.to_s.humanize)
        class_names = args.fetch(:class_names, '')
        all_columns[name] = Struct::ReportColumn.new(name, title, class_names)
      end
    end

    def columns
      all_columns
    end

  end
end

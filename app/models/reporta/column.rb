module Reporta
  module Column
    extend ActiveSupport::Concern

    included do
      cattr_accessor :all_columns
      self.all_columns = []
    end

    module ClassMethods
      def column(name)
        all_columns << name unless all_columns.include?(name)
      end
    end

    def columns
      all_columns
    end

  end
end

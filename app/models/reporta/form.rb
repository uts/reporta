module Reporta
  class Form
    include ActiveModel::Validations
    include ActiveModel::Conversion

    def initialize(filters)
      self.class.send :attr_accessor, *filters.keys
    end

    def persisted?
      false
    end
  end
end

module Reporta
  class Form
    include ActiveModel::Validations
    include ActiveModel::Conversion

    def persisted?
      false
    end
  end
end

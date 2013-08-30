module Reporta
  module Report
    extend ActiveSupport::Concern
    include Filter
    include Column

    attr_accessor :form

    def initialize(args={})
      args ||= {}
      @form = Reporta::Form.new filters, args
      form.valid? if args.present?
    end

    private

    # Delegate any undefined message to the @form object.
    # This allows you to call `report.start_date` to get the value of the
    # `start_date` filter or assign a value using
    # `report.start_date = '2013-01-01'`
    def method_missing(*args, &block)
      self.form.send(*args, &block)
    end
  end
end

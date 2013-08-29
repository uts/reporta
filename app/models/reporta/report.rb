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

    def method_missing(*args, &block)
      self.form.send(*args, &block)
    end
  end
end

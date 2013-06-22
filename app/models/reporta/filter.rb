module Reporta
  module Filter
    extend ActiveSupport::Concern

    included do
      cattr_accessor :all_filters
      self.all_filters = {}
    end

    module ClassMethods
      def filter(name, options={})
        all_filters[name] = options
      end
    end

    attr_accessor :filtered_by, :errors

    def initialize(args={})
      @errors = {}

      self.all_filters.each do |name, option|
        self.class.send :attr_accessor, name
        send "#{name}=", args[name] || option.try(:[], :default) # DISCUSS: find a clean way

        if option[:required] && send(name).blank?
          @errors[name] = "Can't be blank"
        end

        self.filtered_by = args[:filtered_by]
      end
    end

    def filters
      self.all_filters.map do |name, options|
        OpenStruct.new(name: name, options: options)
      end
    end

  end
end

module Reporta
  module Filter
    extend ActiveSupport::Concern
    Struct.new 'ReportFilter', :as, :name, :default, :required, :collection, :include_blank

    included do
      cattr_accessor :all_filters
      self.all_filters = {}
    end

    module ClassMethods
      def filter(name, options={})
        report_filter = Struct::ReportFilter.new(
          as: options.fetch(:as, nil),
          name: options.fetch(:name, name.to_s.humanize),
          default: options.fetch(:default, nil),
          required: options.fetch(:required, false),
          collection: options.fetch(:collection, []),
          include_blank: options.fetch(:include_blank, true)
        )
        all_filters[name] = report_filter
      end
    end

    attr_accessor :filtered_by, :errors

    def initialize(args={})
      # @errors = {}

      puts args.inspect

      # self.all_filters.each do |name|

      #   self.class.send :attr_accessor, name.name
      #   send "#{name}=", name] || option.try(:[], :default) # DISCUSS: find a clean way

      #   self.class.send :attr_accessor, name
      #   send "#{name}=", args[name] || option.try(:[], :default) # DISCUSS: find a clean way

      #   if option[:required] && send(name).blank?
      #     @errors[name] = "Can't be blank"
      #   end

      #   self.filtered_by = args[:filtered_by]
      # end
    end

    def filters
      all_filters
      # self.all_filters.map do |name, options|
      #   OpenStruct.new(name: name, options: options)
      # end
    end

  end
end

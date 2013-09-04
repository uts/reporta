require 'ostruct'

module Reporta
  module Chart
    extend ActiveSupport::Concern

    included do
      cattr_accessor :x_axis_options, :y_axis_options, :line_charts, :column_charts
      self.line_charts = {}
      self.column_charts = {}
    end

    module ClassMethods
      def x_axis(name, options={})
        title = (options[:title] || name).to_s.humanize
        self.x_axis_options = OpenStruct.new options.reverse_merge(
          name: name,
          title: title
        )
      end

      def y_axis(name, options={})
        title = (options[:title] || name).to_s.humanize
        self.y_axis_options = OpenStruct.new options.reverse_merge(title: title)
      end

      def line_chart(name, options={})
        title = (options[:title] || name).to_s.humanize
        self.line_charts[name] = OpenStruct.new options.reverse_merge(title: title)
      end

      def column_chart(name, options={})
        title = (options[:title] || name).to_s.humanize
        self.column_charts[name] = OpenStruct.new options.reverse_merge(title: title)
      end
    end

    def x_axis
      x_axis_options
    end

    def y_axis
      y_axis_options
    end

    def series_for(name)
      self.send(x_axis.name).map do |x|
        self.send(name, x)
      end
    end

  end
end

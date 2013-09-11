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

    def data
      result = []
      line_charts.each do |name, options|
        result << common_data(name, options).reverse_merge(
          lines: { show: true }
        )
      end
      column_charts.each do |name, options|
        result << common_data(name, options).reverse_merge(
          bars: {
            show: true,
            lineWidth: (options.line_width || 10),
            align: (options.align || 'left')
          }
        )
      end
      result.to_json
    end

    def options
      {
        xaxis: {
          mode: (x_axis.as == :date ? 'time' : nil),
          timeformat: (x_axis.as == :date ? x_axis.format : nil),
        }
      }.to_json
    end

    private

    # This is the data that is common to all series regarless of what type it is
    # Commented out options are availabe in Flot but not implemented in Reporta
    def common_data(name, options)
      {
        # color: color or number
        label: name.to_s.humanize,
        data: series_for(name)
        # xaxis: number
        # yaxis: number
        # clickable: boolean
        # hoverable: boolean
        # shadowSize: number
        # highlightColor: color or number
      }
    end
  end
end

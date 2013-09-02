require 'ostruct'

module Reporta
  module Chart
    extend ActiveSupport::Concern

    included do
      cattr_accessor :x_axis_options, :y_axis_options
    end

    module ClassMethods
      def x_axis(name, options={})
        title = (options[:title] || name).to_s.humanize
        self.x_axis_options = OpenStruct.new options.reverse_merge(title: title)
      end

      def y_axis(name, options={})
        title = (options[:title] || name).to_s.humanize
        self.y_axis_options = OpenStruct.new options.reverse_merge(title: title)
      end

      def line_chart(name, options={})
      end

      def column_chart(name, options={})
      end
    end

    def x_axis
      x_axis_options
    end

    def y_axis
      y_axis_options
    end
  end
end

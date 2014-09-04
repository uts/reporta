require 'rails/generators/base'

module Reporta
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      public_task :copy_views

      def copy_views
        view_directory :reports
      end
      
      def view_directory(name, _target_path = nil)
        directory name.to_s, _target_path || "#{target_path}/#{name}" do |content|
          content
        end
      end

      def target_path
        @target_path ||= "app/views/reporta"
      end
    end
  end
end

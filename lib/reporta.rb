require 'reporta/railtie' if defined?(Rails)
module Reporta
  extend ActiveSupport::Concern
  extend ActiveSupport::Autoload
  
  autoload :Form, 'reporta/models/form'
  autoload :Filter, 'reporta/models/filter'
  autoload :Column, 'reporta/models/column'
  autoload :Chart, 'reporta/models/chart'
  autoload :Report, 'reporta/models/report'
end

require 'reporta/railtie' if defined?(Rails)
module Reporta
  extend ActiveSupport::Concern
  extend ActiveSupport::Autoload
  
  # view model
  autoload :Form, 'reporta/models/form'
  autoload :Filter, 'reporta/models/filter'
  autoload :Column, 'reporta/models/column'

  autoload :Report, 'reporta/models/report'  

  autoload :Chart, 'reporta/models/chart'
  
  autoload :ViewHelper, 'reporta/view_helper'
  autoload :ChartjsHelper, 'reporta/chartjs_helper'
  autoload :BoxHelper, 'reporta/box_helper'
end

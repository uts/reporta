require 'reporta/view_helper'
module Reporta
  class Railtie < Rails::Railtie
    initializer "reporta.application_helper" do 
      ActionView::Base.send :include, ViewHelper
    end
  end
end

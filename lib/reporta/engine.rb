module Reporta
  class Engine < ::Rails::Engine
    isolate_namespace Reporta

    initializer 'reporta.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Reporta::Engine.helpers
      end
    end

  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper Reporta::Engine.helpers
end

Rails.application.routes.draw do
  root to: "reports#index"
  match '/', to: 'reports#index', via: [:get, :post]
end

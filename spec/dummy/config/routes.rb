Rails.application.routes.draw do
  resources :reports
  resources :forms
  root to: "reports#index"
end

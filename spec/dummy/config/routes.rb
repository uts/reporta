Rails.application.routes.draw do
  root to: "reports#table"
  match '/', to: 'reports#table', via: :post

  %w(table dynamic_table).each do |action|
    match "/#{action}", to: "reports##{action}", via: [:get, :post]
  end
end

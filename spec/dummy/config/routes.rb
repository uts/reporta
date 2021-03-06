Rails.application.routes.draw do
  root to: "reports#overview"

  %w(table dynamic_table dynamic_table_with_bootstrap chart).each do |action|
    match "/#{action}", to: "reports##{action}", via: [:get, :post]
  end
end

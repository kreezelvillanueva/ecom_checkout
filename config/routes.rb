Rails.application.routes.draw do
  # Set the root path to products index
  root "products#index"

  # Define only the necessary routes for Products
  resources :products, only: [:index, :new, :create]

  # Health check route (keeps the original)
  get "up" => "rails/health#show", as: :rails_health_check
end

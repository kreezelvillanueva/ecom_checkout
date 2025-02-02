Rails.application.routes.draw do
  # Set the root path to products index
  root "home#index"

  # Define only the necessary routes for Products
  resources :products, only: [:index, :create]
  resources :carts, only: [:index, :show, :update, :destroy]

  # Health check route (keeps the original)
  get "up" => "rails/health#show", as: :rails_health_check
end

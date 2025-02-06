# frozen_string_literal: true

Rails.application.routes.draw do
  # Set the root path to products index
  root "home#index"

  # Define only the necessary routes for Products
  resources :products, only: %i[index create]
  resources :carts, only: %i[index show update destroy]

  # Health check route (keeps the original)
  get "up" => "rails/health#show", as: :rails_health_check
end

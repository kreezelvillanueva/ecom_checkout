class ProductsController < ApplicationController
  skip_forgery_protection only: [:create]  # ✅ Since React sends JSON

  def create
    if params[:file].present?
      products = ProductLoader.load_products_from_file(params[:file])

      products.each do |product_data|
        Product.find_or_create_by(uuid: product_data[:uuid]) do |product|
          product.name = product_data[:name]
          product.price = product_data[:price].to_d
        end
      end

      render json: { message: "Products uploaded successfully!" }, status: :ok  # ✅ Return JSON
    else
      render json: { error: "No file provided" }, status: :unprocessable_entity
    end
  end

  def index
    @products = Product.all
    respond_to do |format|
      format.json { render json: @products } # API response
    end
  end
end

class ProductsController < ApplicationController
  def new
  end

  def create
    if params[:file].present?
      products = ProductLoader.load_products_from_file(params[:file])

      products.each do |product_data|
        Product.find_or_create_by(uuid: product_data[:uuid]) do |product|
          product.name = product_data[:name]
          product.price = product_data[:price].to_d
        end
      end

      flash[:notice] = "Products uploaded successfully!"
      redirect_to products_path
    else
      flash[:alert] = "Please select a file to upload."
      render :new
    end
  end

  def index
    @products = Product.all
    respond_to do |format|
      format.html # Loads the view
      format.json { render json: @products } # API response
    end
  end
end

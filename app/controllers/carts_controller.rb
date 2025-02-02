class CartsController < ApplicationController

  def index
    cart = Cart.find_or_create_by(user_id: session[:user_id] || 1)
    render_cart_items(cart)
  end

  def show
    cart = set_cart
    render_cart_items(cart)
  end

  def update
    cart = set_cart
    product = Product.find_by(uuid: params[:product_id])
    cart_item = cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = cart_item.new_record? ? 1 : cart_item.quantity + 1
    cart_item.unit_price = product.price
    cart_item.save!

    render_cart_items(cart)
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    cart = set_cart
    cart_item = cart.cart_items.find_by(id: params[:id])

    if cart_item
      cart_item.destroy
    end

    render_cart_items(cart)
  end

  private

  def render_cart_items(cart)
    render json: cart.cart_items.includes(:product).map { |item| 
      {
        id: item.id,
        product: {
          uuid: item.product.uuid,
          name: item.product.name,
          price: item.product.price
        },
        quantity: item.quantity
      }
    }
  end

  def set_cart
    user_id = session[:user_id] || 1
    Cart.find_or_create_by(user_id: user_id)
  end
end

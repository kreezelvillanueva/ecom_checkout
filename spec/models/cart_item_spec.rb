require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it { should belong_to(:cart) }
  it { should belong_to(:product) }

  it "should have a valid quantity" do
    cart_item = CartItem.new(quantity: 1)
    expect(cart_item).to be_valid
  end

  it "should not allow quantity less than 1" do
    cart_item = CartItem.new(quantity: 0)
    expect(cart_item).not_to be_valid
  end

  it "should store unit_price correctly" do
    cart = Cart.create(user_id: 1)
    product = Product.create(uuid: 123, name: "Test Product", price: 10.0)
    cart_item = CartItem.create(cart: cart, product: product, quantity: 1, unit_price: product.price)

    expect(cart_item
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe CartItem, type: :model do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }

  it { is_expected.to belong_to(:cart) }
  it { is_expected.to belong_to(:product) }

  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }

  it { is_expected.to validate_presence_of(:unit_price) }
  it { is_expected.to validate_numericality_of(:unit_price).is_greater_than(0) }

  it "is valid with a cart, product, quantity, and unit_price" do
    cart_item = CartItem.new(cart: cart, product: product, quantity: 1, unit_price: 10.50)

    expect(cart_item).to be_valid
  end

  it "is invalid without a cart" do
    cart_item = CartItem.new(cart: nil, product: product, quantity: 1, unit_price: 10.50)

    expect(cart_item).not_to be_valid
  end

  it "is invalid without a product" do
    cart_item = CartItem.new(cart: cart, product: nil, quantity: 1, unit_price: 10.50)

    expect(cart_item).not_to be_valid
  end

  it "is invalid with a quantity less than 1" do
    cart_item = CartItem.new(cart: cart, product: product, quantity: 0, unit_price: 10.50)

    expect(cart_item).not_to be_valid
  end

  it "is invalid with a unit_price less than or equal to 0" do
    cart_item = CartItem.new(cart: cart, product: product, quantity: 1, unit_price: 0)

    expect(cart_item).not_to be_valid
  end
end

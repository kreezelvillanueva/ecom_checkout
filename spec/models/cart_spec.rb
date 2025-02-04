require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should have_many(:cart_items).dependent(:destroy) }  # ✅ Ensures cart has many cart_items

  it "should be valid with a user_id" do
    cart = Cart.new(user_id: 1)
    expect(cart).to be_valid
  end

  it "should not be valid without a user_id" do
    cart = Cart.new
    expect(cart).not_to be_valid
  end
end

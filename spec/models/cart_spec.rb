# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cart, type: :model do
  it { is_expected.to have_many(:cart_items).dependent(:destroy) }

  it "should be valid with a user_id" do
    cart = Cart.new(user_id: 1)
    expect(cart).to be_valid
  end
end

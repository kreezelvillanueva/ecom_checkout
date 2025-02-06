# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Carts API", type: :request do
  let!(:cart) { create(:cart, user_id: 1) }
  let!(:product) { create(:product) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1, unit_price: product.price) }

  describe "GET /carts.json" do
    it "returns the cart items" do
      get carts_path, params: {}, headers: { "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:ok)
      json_response = response.parsed_body
      expect(json_response).to be_an(Array)
      expect(json_response.first["product"]["uuid"]).to eq(product.uuid)
    end
  end
end

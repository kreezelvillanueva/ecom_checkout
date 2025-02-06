# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CartItems API", type: :request do
  let!(:cart) { create(:cart) }
  let!(:product) { create(:product) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 2, unit_price: product.price) }

  describe "PATCH /carts" do
    it "adds a product to the cart" do
      patch "/carts/#{product.uuid}", params: { product_id: product.uuid }, headers: { "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:ok)

      json_response = response.parsed_body
      expect(json_response).to be_an(Array)
      expect(json_response.any? { |item| item["product"]["uuid"] == product.uuid }).to be true
    end
  end

  describe "DELETE /carts/:id" do
    it "removes a product from the cart" do
      expect do
        delete "/carts/#{cart_item.id}", headers: { "CONTENT_TYPE" => "application/json" }
        cart.reload
      end.to change { cart.cart_items.count }.by(-1)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include("application/json")
    end

    it "returns a 404 if the product is not in the cart" do
      delete "/cart/999999" # Invalid product ID
      expect(response).to have_http_status(:not_found)
    end
  end
end

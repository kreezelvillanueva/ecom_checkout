require 'rails_helper'

RSpec.describe "Products API", type: :request do
  describe "GET /products" do
    it "returns a successful response" do
      get products_path, headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:success)
    end

    it "returns JSON when requested" do
      get products_path, headers: { "ACCEPT" => "application/json" }
      expect(response.content_type).to include("application/json")
    end
  end

  describe "POST /products" do
    let(:valid_file) { fixture_file_upload("products.json", "application/json") }
  
    it "uploads products successfully" do
      post products_path, params: { file: valid_file }
  
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq("Products uploaded successfully!")
    end

    it "fails to upload if no file is provided" do
      post products_path, params: {}, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body["error"]).to eq("No file provided")
    end
  end
end

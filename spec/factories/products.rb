# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    uuid { SecureRandom.uuid }
    name { "Sample Product" }
    price { 19.99 }
  end
end

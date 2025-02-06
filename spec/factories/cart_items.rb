# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    sequence(:id) { |n| n }
    quantity { 1 }
    unit_price { 9.99 }
    association :cart, factory: :cart
    association :product, factory: :product
  end
end

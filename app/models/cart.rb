# frozen_string_literal: true

# This model represents a cart
class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
end

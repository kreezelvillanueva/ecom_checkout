# frozen_string_literal: true

# This model represents a cart item
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  before_save :update_subtotal_price

  private

  def update_subtotal_price
    self.subtotal_price = quantity * unit_price
  end
end

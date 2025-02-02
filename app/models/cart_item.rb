class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :update_subtotal_price

  private

  def update_subtotal_price
    self.subtotal_price = quantity * unit_price
  end
end

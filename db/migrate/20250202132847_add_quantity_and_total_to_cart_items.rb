# frozen_string_literal: true

# This migration adds quantity, unit_price and subtotal_price to cart_items
class AddQuantityAndTotalToCartItems < ActiveRecord::Migration[7.1]
  def change
    change_table :cart_items, bulk: true do |t|
      t.integer :quantity, default: 1, null: false
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :subtotal_price, precision: 10, scale: 2
    end
  end
end

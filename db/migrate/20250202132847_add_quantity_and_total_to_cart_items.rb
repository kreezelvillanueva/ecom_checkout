class AddQuantityAndTotalToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :quantity, :integer, default: 1, null: false
    add_column :cart_items, :unit_price, :decimal, precision: 10, scale: 2, null: false
    add_column :cart_items, :subtotal_price, :decimal, precision: 10, scale: 2, null: false
  end
end

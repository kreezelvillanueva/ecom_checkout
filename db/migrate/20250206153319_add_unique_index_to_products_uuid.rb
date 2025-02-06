# frozen_string_literal: true

# This migration adds a unique index to the uuid column in the products table
class AddUniqueIndexToProductsUuid < ActiveRecord::Migration[7.0]
  def change
    add_index :products, :uuid, unique: true
  end
end

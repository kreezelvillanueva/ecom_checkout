# frozen_string_literal: true

# This migration creates the products table
class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.integer :uuid
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end

# frozen_string_literal: true

# This migration creates the carts table
class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddIndexToUser < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :confirmation_token,   unique: true
  end
end

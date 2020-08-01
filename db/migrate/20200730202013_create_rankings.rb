# frozen_string_literal: true

class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.integer :rank
      t.references :keyword, null: false, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.string :keyword, null: false
      t.integer :url_id, null: false

      t.timestamps
    end
    add_index :keywords, :url_id
  end
end

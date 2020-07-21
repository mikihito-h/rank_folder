class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :url, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end

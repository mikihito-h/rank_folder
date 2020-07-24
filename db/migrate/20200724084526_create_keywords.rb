class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.integer :url_id

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddIndexUrlsUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :urls, :user_id
    change_column_null :urls, :user_id, false
  end
end

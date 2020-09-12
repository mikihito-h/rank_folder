# frozen_string_literal: true

class AddForeignKey < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :keywords, :urls
    add_foreign_key :urls, :users
  end
end

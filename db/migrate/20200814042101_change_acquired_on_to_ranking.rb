# frozen_string_literal: true

class ChangeAcquiredOnToRanking < ActiveRecord::Migration[6.0]
  def change
    add_index :rankings, [:keyword_id, :acquired_on], unique: true
  end
end

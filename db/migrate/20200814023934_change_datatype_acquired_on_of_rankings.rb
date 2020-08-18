# frozen_string_literal: true

class ChangeDatatypeAcquiredOnOfRankings < ActiveRecord::Migration[6.0]
  def change
    change_column :rankings, :acquired_on, "date USING acquired_on::date"
  end
end

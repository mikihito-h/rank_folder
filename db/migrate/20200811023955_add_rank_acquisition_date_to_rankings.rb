# frozen_string_literal: true

class AddRankAcquisitionDateToRankings < ActiveRecord::Migration[6.0]
  def change
    add_column :rankings, :rank_acquisition_date, :string, null: false
  end
end

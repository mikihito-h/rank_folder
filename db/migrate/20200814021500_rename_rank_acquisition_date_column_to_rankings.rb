# frozen_string_literal: true

class RenameRankAcquisitionDateColumnToRankings < ActiveRecord::Migration[6.0]
  def change
    rename_column :rankings, :rank_acquisition_date, :acquired_on
  end
end

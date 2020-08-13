# frozen_string_literal: true

class ChangeRankingsRankNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :rankings, :rank, false
  end
end

class ChangeDataTypeTotalScoreOfSupplements < ActiveRecord::Migration[6.0]
  def change
    change_column :supplements, :total_score, :float
  end
end
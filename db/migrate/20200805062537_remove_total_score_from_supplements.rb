class RemoveTotalScoreFromSupplements < ActiveRecord::Migration[6.0]
  def change
    remove_column :supplements, :total_score, :float
  end
end

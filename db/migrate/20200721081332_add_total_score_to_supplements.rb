class AddTotalScoreToSupplements < ActiveRecord::Migration[6.0]
  def change
    add_column :supplements, :total_score, :integer
  end
end

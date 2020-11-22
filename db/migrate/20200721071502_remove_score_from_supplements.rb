class RemoveScoreFromSupplements < ActiveRecord::Migration[6.0]
  def change
    remove_column :supplements, :score, :integer
  end
end

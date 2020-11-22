class AddScoreToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :score, :float
  end
end

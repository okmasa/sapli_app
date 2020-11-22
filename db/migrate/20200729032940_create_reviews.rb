class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :supplement, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:user_id, :created_at]
    add_index :reviews, [:supplement_id, :created_at]
  end
end

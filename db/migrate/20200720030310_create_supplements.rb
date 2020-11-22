class CreateSupplements < ActiveRecord::Migration[6.0]
  def change
    create_table :supplements do |t|
      t.string :name
      t.integer :score
      t.string :img

      t.timestamps
    end
  end
end

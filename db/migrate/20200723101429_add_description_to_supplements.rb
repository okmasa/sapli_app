class AddDescriptionToSupplements < ActiveRecord::Migration[6.0]
  def change
    add_column :supplements, :description, :text
  end
end

class AddReferencesToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_reference :microposts, :supplement, foreign_key: true
  end
end
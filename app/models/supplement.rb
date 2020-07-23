class Supplement < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  #micropostに移動予定
  # validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  has_one_attached :img
  # is not numberエラーが出る
  # validates :total_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
class Supplement < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  #micropostに移動予定
  # validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  has_one_attached :img
  validates :img, content_type: { in:      %w[image/jpeg image/gif image/png],
  message: "画像フォーマットが正しくありません" },
  size:   { less_than: 5.megabytes,
            message: "should be less than 5MB" }
  validates :description, length: { maximum: 500 }
  validates :total_score, allow_nil: true, numericality: { greater_than_or_equal_to: 0,
                                                           less_than_or_equal_to:    5}
end
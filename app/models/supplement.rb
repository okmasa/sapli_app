class Supplement < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
  # accepts_nested_attributes_for :users
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  has_one_attached :img
  validates :img, content_type: { in:      %w[image/jpeg image/gif image/png],
  message: "画像フォーマットが正しくありません" },
  size:   { less_than: 5.megabytes,
            message: "should be less than 5MB" }
  validates :description, length: { maximum: 500 }
  validates :total_score, allow_nil: true, numericality: { greater_than_or_equal_to: 0,
                                                           less_than_or_equal_to:    5}

  # def review
  #   Micropost.where("supplement_id = ?", id)
  # end
end
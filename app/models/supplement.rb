class Supplement < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
  has_many :favorites
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  has_one_attached :img
  validates :img, content_type: { in:      %w[image/jpeg image/gif image/png],
  message: "画像フォーマットが正しくありません" },
  size:   { less_than: 5.megabytes,
            message: "should be less than 5MB" }
  validates :description, length: { maximum: 500 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # def review
  #   Micropost.where("supplement_id = ?", id)
  # end
end
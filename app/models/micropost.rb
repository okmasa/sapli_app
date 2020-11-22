class Micropost < ApplicationRecord
  belongs_to :user
  #supplement_idのnilを許容
  # belongs_to :supplement, optional: true
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :score, allow_nil: true, numericality: { greater_than_or_equal_to: 0,
                                                     less_than_or_equal_to:    5 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                               message: "jpg/png/gifのみアップロードできます" },
                    size:         { less_than: 5.megabytes,
                                      message: "5MB以下の画像を選択して下さい" }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  def reviewed_by?(supplement)
    micropost.where(supplement_id: supplement.id).exists?
  end
  
end
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :supplement
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  # validates :supplement_id, presence: true
  validates :content, length: { maximum: 140 }
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0,
  less_than_or_equal_to:    5 }
end
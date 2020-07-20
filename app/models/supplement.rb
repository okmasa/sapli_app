class Supplement < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  has_one_attached :img
end
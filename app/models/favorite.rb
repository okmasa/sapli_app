class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :supplement
  validates :user_id, presence: true
  validates :supplement_id, presence: true
end

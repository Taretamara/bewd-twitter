class Tweet < ApplicationRecord
  validates :user_id, presence: true
  validates :message, :length: { maximum: 140 }, :allow_blank => true
  belongs_to :user,
end

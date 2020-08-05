class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  have_one_attached :image

  validates :content, presence: true
end
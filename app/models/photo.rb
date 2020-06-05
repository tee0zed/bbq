class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true
  validates :discription, length: { maximum: 70 }

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> { where('id IS NOT NULL') }
end

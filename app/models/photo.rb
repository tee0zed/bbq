class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :photo, presence: true
  validates :user, presence: true
  validates :event, presence: true
  validates :discription, length: { maximum: 70 },
            presence: true

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> { where('id IS NOT NULL') }
end

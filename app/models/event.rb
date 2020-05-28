class Event < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title,
            presence: true,
            length: { maximum: 75 }

  validates :description,
            presence: true,
            length: { maximum: 355 }

  validates :address,
            presence: true,
            length: { maximum: 150 }
end

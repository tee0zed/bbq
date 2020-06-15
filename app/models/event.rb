class Event < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos, dependent: :destroy

  validates :title,
            presence: true,
            length: { maximum: 75 }

  validates :description,
            presence: true,
            length: { maximum: 355 }

  validates :address,
            presence: true,
            length: { maximum: 150 }

  def visitors
    (subscribers + [user]).uniq
  end

  def pincode_valid?(pin_to_check)
    pincode == pin_to_check
  end
end

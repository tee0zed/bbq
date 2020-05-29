class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :event, presence: true

  validates :user, uniqueness: {scope: :event_id}, if: :user_present?

  validates :user_name, presence: true, unless: :user_present?

  validates :user_email,
            presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? },
            uniqueness: {scope: :event_id}, unless: :user_present?

  private

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def user_present?
    user.present?
  end
end
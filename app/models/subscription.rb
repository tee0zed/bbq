class Subscription < ActiveRecord::Base
  EMAIL_REGEXP = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  belongs_to :event
  belongs_to :user, optional: true

  validates :user, uniqueness: {scope: :event_id}, if: :user_present?
  validates :user_email, uniqueness: {scope: :event_id}

  validates :event, presence: true
  validates :user_name, presence: true, unless: :user_present?
  validates :user_email, presence: true, format: { with: EMAIL_REGEXP }, unless: :user_present?

  validate :user_is_author, if: :user_present?
  validate :email_taken, unless: :user_present?

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

  private

  def user_is_author
    if user.id == event.user_id
      errors.add(user.name, :subscribed)
    end
  end

  def email_taken
    if User.find_by(email: user_email)
      errors.add(:user_email, :email_taken)
    end
  end

  def user_present?
    user.present?
  end
end
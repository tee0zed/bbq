class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :comments

  before_save :set_name

  private

  def set_name
    self.name = self.name = "%%Username%% №#{rand(777)}" if self.name.blank?
  end
end

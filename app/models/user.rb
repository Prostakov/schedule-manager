class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation
  has_secure_password

  has_many :schedules, dependent: :destroy

  validates :name, presence: true, length: { within: 3..10 }
  validates :password, presence: true, length: { within: 3..10 }
  validates :password_confirmation, presence: true, length: { within: 3..10 }

  before_save :create_remember_token

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end
end

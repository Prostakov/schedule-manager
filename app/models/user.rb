class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation
  has_secure_password

  has_many :schedules, dependent: :destroy

  validates :name, presence: true, length: { within: 3..10 }
  validates :password, presence: true, length: { within: 3..10 }
  validates :password_confirmation, presence: true, length: { within: 3..10 }

  before_save :create_remember_token

  def hack_password
    counts = 10
    while counts != 0
       k = STDIN.gets.chomp.split(' ')[0]
       return "Fuck Yeah! The password is #{k}" if self.authenticate(k)
       counts -= 1
    end
    "You\'ve lost! Congrats, sucker!"
  end

  private

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end
end

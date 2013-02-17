class Schedule < ActiveRecord::Base
  attr_accessible :name, :weeks
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true, length: {minimum: 3}
end

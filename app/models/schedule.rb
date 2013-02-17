class Schedule < ActiveRecord::Base
  attr_accessible :name, :weeks
  belongs_to :user
  has_many :items, dependent: :destroy
end

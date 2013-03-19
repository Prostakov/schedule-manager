class Group < ActiveRecord::Base
  attr_accessible :name, :slug

  belongs_to :school
  has_many :schedules

  validates :name, presence: true, length: {minimum: 2, maximum: 10}, uniqueness: {case_sensitive: false}
  validates :slug, presence: true
end

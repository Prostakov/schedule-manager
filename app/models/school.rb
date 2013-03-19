class School < ActiveRecord::Base
  attr_accessible :name, :slug

  belongs_to :user
  has_many :groups
  
  validates :name, presence: true, length: {minimum: 2, maximum: 10}, uniqueness: {case_sensitive: false}
  validates :slug, presence: true
end

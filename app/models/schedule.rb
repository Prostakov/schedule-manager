class Schedule < ActiveRecord::Base
  attr_accessible :name, :weeks, :weeks_counter, :local_time, :lesson1, :lesson2, :lesson3, :lesson4, :lesson5, :lesson6
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true, length: {minimum: 2, maximum: 6}, uniqueness: {case_sensitive: false}

  before_save :create_slug

  def to_param
    name.downcase
  end

  private

  def create_slug
  	self.slug = self.name.parameterize
  end
end

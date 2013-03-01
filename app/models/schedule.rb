class Schedule < ActiveRecord::Base
  attr_accessible :name, :weeks, :weeks_counter, :local_time, :lesson1, :lesson2, :lesson3, :lesson4, :lesson5, :lesson6
  belongs_to :user
  has_many :items, dependent: :destroy

  before_save :create_slug

  VALID_LESSON_REGEX = /\A\d{2}:\d{2}\s-\s\d{2}:\d{2}\z/

  validates :name, presence: true, length: {minimum: 2, maximum: 6}, uniqueness: {case_sensitive: false}
  validates :lesson1, format: { with: VALID_LESSON_REGEX }
  validates :lesson2, format: { with: VALID_LESSON_REGEX }
  validates :lesson3, format: { with: VALID_LESSON_REGEX }
  validates :lesson4, format: { with: VALID_LESSON_REGEX }
  validates :lesson5, format: { with: VALID_LESSON_REGEX }
  validates :lesson6, format: { with: VALID_LESSON_REGEX }

  def to_param
    name.downcase
  end

  private

  def create_slug
  	self.slug = self.name.parameterize
  end
end

class Schedule < ActiveRecord::Base
  attr_accessible :name, :weeks, :weeks_counter, :local_time, :lesson1, :lesson2, :lesson3, :lesson4, :lesson5, :lesson6
  belongs_to :user
  belongs_to :group
  has_many :items, dependent: :destroy

  before_save :create_slug

  VALID_LESSON_REGEX = /\A\d{2}:\d{2}\s-\s\d{2}:\d{2}\z/

  validates :name, presence: true, length: {minimum: 2, maximum: 10}
  validates_format_of :lesson1, with: VALID_LESSON_REGEX, allow_blank: true
  validates_format_of :lesson2, with: VALID_LESSON_REGEX, allow_blank: true
  validates_format_of :lesson3, with: VALID_LESSON_REGEX, allow_blank: true
  validates_format_of :lesson4, with: VALID_LESSON_REGEX, allow_blank: true
  validates_format_of :lesson5, with: VALID_LESSON_REGEX, allow_blank: true
  validates_format_of :lesson6, with: VALID_LESSON_REGEX, allow_blank: true

  def to_param
    self.slug
  end

  private

  def create_slug
  	self.slug = self.name.parameterize
  end

  def slug_uniqueness_validation
    return false unless Schedule.find_by_slug(self.slug).nil?
  end
end

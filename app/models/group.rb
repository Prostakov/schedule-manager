class Group < ActiveRecord::Base
  attr_accessible :name, :slug

  belongs_to :school
  has_many :schedules, dependent: :destroy

  before_save :slug_uniqueness_validation

  validates :name, presence: true, length: {minimum: 2, maximum: 40}
  validates :slug, presence: true

  def to_param
    self.slug
  end

  private

  def slug_uniqueness_validation
  	return false unless Group.where(school_id: self.school.id, slug: self.slug).empty?
  end
end

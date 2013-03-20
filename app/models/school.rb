class School < ActiveRecord::Base
  attr_accessible :name, :slug

  belongs_to :user
  has_many :groups, dependent: :destroy

  validates :name, presence: true, length: {minimum: 2, maximum: 30}, uniqueness: {case_sensitive: false}
  validates :slug, presence: true

  def to_param
    self.slug
  end
end

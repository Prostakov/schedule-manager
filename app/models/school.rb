class School < ActiveRecord::Base
  attr_accessible :name, :slug

  belongs_to :user
  has_many :groups, dependent: :destroy

  validates :name, length: {minimum: 2, maximum: 30}
  validates :slug, uniqueness: {case_sensitive: false}, length: {minimum: 2, maximum: 20}

  def to_param
    self.slug
  end

end

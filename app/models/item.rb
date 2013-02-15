class Item < ActiveRecord::Base
  attr_accessible :day, :location, :name, :position, :schedule_id, :teacher, :week1, :week2
  belongs_to :schedule

  validates :name, presence: true
end

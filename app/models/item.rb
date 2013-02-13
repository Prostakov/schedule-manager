class Item < ActiveRecord::Base
  attr_accessible :day, :location, :name, :position, :schedule_id, :teacher, :week1, :week2
  belongs_to :schedule

  before_save :create_duplicate

  private

  def create_duplicate
  	if self.week1 && self.week2
  		@temp = self
  		@temp.week2 = false
  		@temp.save
  		@temp.week2 = true
  		@temp.week1 = false
  		@temp.save
  	end
  end
end

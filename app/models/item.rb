class Item < ActiveRecord::Base
  attr_accessible :day, :location, :name, :position, :schedule_id, :teacher, :week1, :week2
  belongs_to :schedule

  validates :name, presence: true

  before_save do
  	@schedule = self.schedule
  	@items = @schedule.items
  	@items = filter_items @items, self.day, self.position
  	if @items.length > 1 || 
  	@items[0] && @items[0].week1 && @items[0].week2 || 
  	@items[0] && @items[0].week1 && self.week1 ||
  	@items[1] && @items[1].week2 && self.week2 ||
  	self.week1 && self.week2 && !@items.empty?
  		return false
  	end
  	true
  end

  private

  def filter_items items, day, position
  	@result = []
  	items.each do |item|
  		if item.day == day && item.position == position
  			@result.push item
  		end
  	end
  	return @result
  end

end

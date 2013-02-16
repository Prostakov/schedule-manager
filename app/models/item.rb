class Item < ActiveRecord::Base
  attr_accessible :day, :location, :name, :position, :teacher, :week1, :week2
  belongs_to :schedule

  validates :name, presence: true, length: {minimum: 3}
  validates :position, presence: true, numericality: { greater_than: 0, less_than: 7}
  validates :day, presence: true, numericality: { greater_than: 0, less_than: 7}

  before_save do
  	@object = self
  	@schedule = @object.schedule
  	@items = @schedule.items
  	@items = filter_items @items, self.day, self.position
  	unless @object.id.nil?
  		@items = clear_items @items, @object.id
  	end
  	if @items.length > 1 ||
  	@items[0] && @items[0].week1 && self.week1 ||
  	@items[0] && @items[0].week2 && self.week2 ||
  	!self.week1 && !self.week2
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

  def clear_items items, id
  	@items.delete_if {|x| x.id==id }
  	return @items
  end

end

module SchedulesHelper
	require 'date'

	def sort_positions items
		@result = [nil, [], [], [], [], [], []]
		items.each do |item|
			if item.position == 1
				@result[1].push item
			elsif item.position == 2
				@result[2].push item
			elsif item.position == 3
				@result[3].push item
			elsif item.position == 4
				@result[4].push item
			elsif item.position == 5
				@result[5].push item
			elsif item.position == 6
				@result[6].push item
			end	
		end
		return @result
	end

	def sort_days items
		@result = [nil, [nil,[],[],[],[],[],[]], [nil,[],[],[],[],[],[]], [nil,[],[],[],[],[],[]], [nil,[],[],[],[],[],[]], [nil,[],[],[],[],[],[]], [nil,[],[],[],[],[],[]]]
		(1..6).each do |k|
			items[k].each do |item|
				if item.day == 1
					@result[k][1].push item
				elsif item.day == 2
					@result[k][2].push item
				elsif item.day == 3
					@result[k][3].push item
				elsif item.day == 4
					@result[k][4].push item
				elsif item.day == 5
					@result[k][5].push item
				elsif item.day == 6
					@result[k][6].push item
				end
			end
		end
		return @result
	end

	def sort_weeks items
		(1..6).each do |k|
			(1..6).each do |l|
				if items[k][l][0].nil? && items[k][l][1] &&
				items[k][l][1].week1 && items[k][l][1].week2
					items[k][l][0] = items[k][l][1]
				elsif items[k][l][1].nil? && items[k][l][0] &&
				items[k][l][0].week1 && items[k][l][0].week2
					items[k][l][1] = items[k][l][0]
				elsif items[k][l][0] && items[k][l][1] &&
				items[k][l][0].week2 && items[k][l][1].week1
					@l = items[k][l][0]
					items[k][l][0] = items[k][l][1]
					items[k][l][1] = @l
				elsif items[k][l][0] && items[k][l][0].week2 &&
				!items[k][l][1]
					items[k][l][1] = items[k][l][0]
					items[k][l][0] = nil
				end
			end
		end
		return items
	end


	def define_week schedule
		if schedule.weeks_count.nil?
			return ''
		end
		now = Time.now.getlocal(schedule.local_time).to_date
		current_week = now.strftime("%W").to_i
		counter_week = schedule.weeks_count
		current_week%2 == counter_week%2 ? 'Week 1' : 'Week 2'
	end

	def define_wrong_week schedule
		if schedule.weeks_count.nil?
			return ''
		end
		now = Time.now.getlocal(schedule.local_time).to_date
		current_week = now.strftime("%W").to_i
		counter_week = schedule.weeks_count
		current_week%2 == counter_week%2 ? 'Week 2' : 'Week 1'
	end

	def weeks_count_flash_message schedule
		now = Time.now.getlocal(schedule.local_time).to_date
		unless now.wday == 0 || now.wday == 6
			return ''
		else
			if now.wday == 6
				return 'Today is Saturday, the end of '+define_week(schedule)+'. Starting from Monday it will be '+define_wrong_week(schedule)+'.'
			elsif now.wday == 0
				return 'Today is Sunday, the end of '+define_week(schedule)+'. Starting from tomorrow it will be '+define_wrong_week(schedule)+'.'
			end		
		end
	end

	def weeks_count_red_flash_message schedule
		now = Time.now.getlocal(schedule.local_time).to_date
		current_week = now.strftime("%W").to_i
		counter_week = schedule.weeks_count
		if current_week - counter_week == 5
			return 'This is the last week weeks counter is working. Please update the counter in nearest possible time.'
		end
		''
	end
end

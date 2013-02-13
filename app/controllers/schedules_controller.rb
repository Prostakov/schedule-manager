class SchedulesController < ApplicationController

	def new
	end

	def create
	end 

	def destroy
	end

	def index
	end 

	def show
		@week1blocks = { pos1: [], pos2: [], pos3: [], pos4: [], pos5: [], pos6: []}
		@week2blocks = { pos1: [], pos2: [], pos3: [], pos4: [], pos5: [], pos6: []}
		@schedule = Schedule.find(params[:id])
		@items = @schedule.items
		@items.each do |item|
			if item.position == 1 && week1
				@week1blocks.pos1.push item
			elsif item.position == 2 && week1
				@week1blocks.pos2.push item
			elsif item.position == 3 && week1
				@week1blocks.pos3.push item
			elsif item.position == 4 && week1
				@week1blocks.pos4.push item
			elsif item.position == 5 && week1
				@week1blocks.pos5.push item
			elsif item.position == 6 && week1
				@week1blocks.pos6.push item
			elsif item.position == 1 && week2
				@week2blocks.pos1.push item
			elsif item.position == 2 && week2
				@week2blocks.pos2.push item
			elsif item.position == 3 && week2
				@week2blocks.pos3.push item
			elsif item.position == 4 && week2
				@week2blocks.pos4.push item
			elsif item.position == 5 && week2
				@week2blocks.pos5.push item
			elsif item.position == 6 && week2
				@week2blocks.pos6.push item
			end
		end
	end
end

class SchedulesController < ApplicationController
include SchedulesHelper

	def new
	end

	def create
	end 

	def destroy
	end

	def index
	end 

	def show
		@last_item = Item.last
		@schedule = Schedule.find(params[:id])
		@item = @schedule.items.new
		@items = @schedule.items
		@items = sort_positions @items
		@items = sort_days @items
		@items = sort_weeks @items
		@positions = ['I','II','III','IV','V','VI']
	end
end

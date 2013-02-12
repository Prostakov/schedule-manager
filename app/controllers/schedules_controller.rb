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
		@schedule = Schedule.find(params[:id])
		@items = @schedule.items
	end
end

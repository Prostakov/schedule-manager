class SchedulesController < ApplicationController
	require 'date'
	include SchedulesHelper
	before_filter :correct_user, only: [:update, :destroy, :edit]
	before_filter :correct_user_create, only: :create

	def update
		if params[:counter]
			if params[:counter] == 'start_counter'
				now = Time.now.getlocal(params[:schedule][:local_time]).to_date
				if params[:current_week] == 'Week1'
					@schedule.weeks_count = now.strftime("%W").to_i
				elsif params[:current_week] == 'Week2'
					@schedule.weeks_count = now.strftime("%W").to_i - 1
				end					
				@schedule.update_attributes(params[:schedule]) ? respond_schedule(@schedule) : respond_error(@schedule)
			elsif params[:counter] == 'stop_counter'
				@schedule.update_attributes(params[:schedule]) ? respond_schedule(@schedule) : respond_error(@schedule)
			end
		else
			@schedule.update_attributes(params[:schedule])
			redirect_to root_path
		end
	end

	def create
		@schedule = @user.schedules.new(params[:schedule]);
		@schedule.save ? respond_schedule(@schedule) : respond_error(@schedule)
	end 

	def edit
	end

	def destroy
		@schedule.destroy
		redirect_to root_path
	end 

	def show
		@schedule = Schedule.find_by_slug(params[:id])
		if @schedule.weeks_counter
			now = Time.now.getlocal(@schedule.local_time).to_date
			week = now.strftime("%W").to_i
			unless @schedule.weeks_count.nil?
				if week - @schedule.weeks_count > 5 || week - @schedule.weeks_count < 0
					@schedule.weeks_counter = false
					@schedule.save
				end
			end
		end
		@item = @schedule.items.new
		@items = @schedule.items
		@items = sort_positions @items
		@items = sort_days @items
		@items = sort_weeks @items
		@day = Time.now.getlocal(@schedule.local_time).wday
		@positions = ['I','II','III','IV','V','VI']
	end

	def schedules_count
		render text: Schedule.count.to_s+"\n", status: 200, content_type: 'text/html'
	end

	private

	def correct_user
		@schedule = Schedule.find_by_slug(params[:id])
		@user = @schedule.user
		unless @user == current_user
			redirect_to root_path
		end
	end

	def correct_user_create
		@user = User.find(params[:user])
		unless @user == current_user
			redirect_to root_path
		end
	end

	def respond_schedule schedule
		respond_to do |format|
			format.html { redirect_to schedule }
			format.json { render json: schedule.to_json }
		end
	end

	def respond_error schedule
		respond_to do |format|
			format.html { redirect_to schedule }
			format.json { render json: 'Error'.to_json }
		end		
	end
end

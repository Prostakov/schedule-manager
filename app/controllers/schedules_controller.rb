class SchedulesController < ApplicationController
	include SchedulesHelper
	before_filter :correct_user, only: [:update, :destroy, :edit]
	before_filter :correct_user_create, only: :create

	def update
		@schedule.update_attributes(params[:schedule])
		redirect_to root_path
	end

	def create
		@schedule = @user.schedules.new(params[:schedule]);
		if @schedule.save
			respond_to do |format|
				format.html { redirect_to @schedule }
				format.json { render json: @schedule.to_json }
			end
		else
			respond_to do |format|
				format.html { redirect_to @schedule }
				format.json { render json: 'Error'.to_json }
			end			
		end
	end 

	def edit
	end

	def destroy
		@schedule.destroy
		redirect_to root_path
	end 

	def show
		@schedule = Schedule.find(params[:id])
		@item = @schedule.items.new
		@items = @schedule.items
		@items = sort_positions @items
		@items = sort_days @items
		@items = sort_weeks @items
		@positions = ['I','II','III','IV','V','VI']
	end

	private

	def correct_user
		@schedule = Schedule.find(params[:id])
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
end

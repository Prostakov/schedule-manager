class SchedulesController < ApplicationController
	require 'date'
	include SchedulesHelper
	include ApplicationHelper
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
				@schedule.update_attributes(params[:schedule]) ? respond_obj(@schedule) : respond_obj_error(@schedule)
			elsif params[:counter] == 'stop_counter'
				@schedule.update_attributes(params[:schedule]) ? respond_obj(@schedule) : respond_obj_error(@schedule)
			end
		else
			@schedule.update_attributes(params[:schedule])
			redirect_to belongs_to_school?(@schedule) ? school_group_schedule_path(@school,@group,@schedule) : @schedule
		end
	end

	def create
		@schedule = @user.schedules.new(params[:schedule]);
		@schedule.save ? respond_obj(@schedule) : respond_obj_error(@schedule)
	end 

	def edit
	  if belongs_to_school?(@schedule)
	  	@group = @schedule.group
	  	@school = @group.school
	  end
	end

	def destroy
		@schedule.destroy
		redirect_to root_path
	end 

	def show
	  if params[:school_id].nil?
	    @schedule = Schedule.find_by_slug(params[:id])
	    @user = @schedule.user
	    @day = Time.now.getlocal(@schedule.local_time).wday
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
	  else
	  	@school = School.find_by_slug(params[:school_id])
	  	@user = @school.user
	  	@group = Group.where("school_id=? AND slug=?",@school.id,params[:group_id]).first
	  	@schedule = Schedule.where("group_id=? AND slug=?",@group.id,params[:id]).first
	  	@day = Time.now.getlocal(@school.local_time).wday
	  	if @school.weeks_counter
		  now = Time.now.getlocal(@school.local_time).to_date
		  week = now.strftime("%W").to_i
		  unless @school.weeks_count.nil?
		    if week - @school.weeks_count > 5 || week - @school.weeks_count < 0
		      @school.weeks_counter = false
		      @school.save
		    end
		  end
		end
      end
	  @item = @schedule.items.new
	  @items = @schedule.items
	  @items = sort_positions @items
	  @items = sort_days @items
	  @items = sort_weeks @items
	  @positions = ['I','II','III','IV','V','VI']
	end

	def schedules_count
		render text: Schedule.count.to_s+"\n", status: 200, content_type: 'text/html'
	end

  private

  def correct_user
    @schedule = Schedule.find_by_slug(params[:id])
    if belongs_to_school?(@schedule) 
      @group = @schedule.group
      @school = @group.school
      @user = @school.user
    else
      @user = @schedule.user
    end
    redirect_to root_path unless @user == current_user
  end

  def correct_user_create
    @user = User.find(params[:user])
    redirect_to root_path unless @user == current_user
  end

end

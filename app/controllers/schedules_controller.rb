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
			redirect_to_schedule @schedule
		end
	end

	def create
		if @group.nil?
			@schedule = @user.schedules.new(params[:schedule]);
			@schedule.save ? respond_obj(@schedule) : respond_obj_error(@schedule)
		else
			@schedule = @group.schedules.create(params[:schedule])
			redirect_to school_group_path(@group.school,@group)
		end
	end 

	def edit
	  if belongs_to_school?(@schedule)
	  	@group = @schedule.group
	  	@school = @group.school
	  end
	end

	def destroy
		if @group.nil?
			@schedule.destroy
			redirect_to root_path
		else
			@schedule.destroy
			redirect_to school_group_path(@school,@group)
		end
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
  	if params[:group_id].nil?
  	  @schedule = Schedule.where(group_id: nil, slug: params[:id]).first
  	  @user = @schedule.user
  	else
  	  @school = School.find_by_slug(params[:school_id])
  	  @group = Group.where('school_id = ? AND slug = ?', @school.id, params[:group_id]).first
  	  @schedule = Schedule.where('group_id = ? AND slug = ?', @group.id, params[:id]).first
  	  @user = @school.user
  	end
  	redirect_to root_path unless @user == current_user
  end

  def correct_user_create
    @user = User.find(params[:user])
    @group = Group.find(params[:group]) unless params[:group].nil?
    redirect_to root_path unless @user == current_user
  end

end

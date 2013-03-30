class SchoolsController < ApplicationController
  include ApplicationHelper
  before_filter :correct_user_create, only: [:create]
  before_filter :correct_user, only: [:update, :destroy, :edit]

  def show
  	@school = School.find_by_slug(params[:id])
    @groups = @school.groups
    @group = @school.groups.new
    @user = @school.user
  end

  def create
  	@school = @user.schools.new(params[:school])
  	@school.save ? respond_obj(@school) : respond_obj_error(@school)
  end

  def update
    if params[:counter]
      if params[:counter] == 'start_counter'
        now = Time.now.getlocal(params[:school][:local_time]).to_date
        if params[:current_week] == 'Week1'
          @school.weeks_count = now.strftime("%W").to_i
        elsif params[:current_week] == 'Week2'
          @school.weeks_count = now.strftime("%W").to_i - 1
        end         
        @school.update_attributes(params[:school]) ? respond_obj(@school) : respond_obj_error(@school)
      elsif params[:counter] == 'stop_counter'
        @school.update_attributes(params[:school]) ? respond_obj(@school) : respond_obj_error(@school)
      end
    else
      @school.update_attributes(params[:school])
      redirect_to root_path
    end
  end

  def destroy
  	@school.destroy
  	redirect_to root_path
  end

  def edit
  end

  private

  def correct_user
  	@school = School.find_by_slug(params[:id])
  	@user = @school.user
  	redirect_to root_path unless @user == current_user
  end

  def correct_user_create
  	@user = User.find(params[:user])
  	redirect_to root_path unless @user == current_user
  end
end

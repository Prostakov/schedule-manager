class GroupsController < ApplicationController
  before_filter :correct_user_create, only: [:create]
  before_filter :correct_user, only: [:destroy, :edit, :update]

  def show
    @group = Group.find_by_slug(params[:id])
    @schedule = @group.schedules.new
    @school = @group.school
    @user = @school.user
  end

  def update
    @group.update_attributes(params[:group])
    redirect_to school_group_path(@school,@group)
  end

  def create
    @group = @school.groups.create(params[:group])
    redirect_to school_show_path(@school)
  end

  def destroy
    @group.destroy
    redirect_to school_show_path(@school)
  end

  def edit
  end

  private

  def correct_user
  	@school = School.find_by_slug(params[:school_id])
  	@group = Group.where("school_id = ? AND slug = ?",@school.id,params[:id]).first
  	@user = @school.user
  	redirect_to root_path unless @user == current_user
  end

  def correct_user_create
  	@school = School.find(params[:school])
    @user = @school.user
  	redirect_to root_path unless @user == current_user
  end

  def correct_user_update
  end
end

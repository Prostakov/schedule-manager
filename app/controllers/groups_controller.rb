class GroupsController < ApplicationController
  before_filter :correct_user_create, only: [:create]
  before_filter :correct_user, only: [:update, :destroy, :edit]

  def show
    @group = Group.find_by_slug(params[:id])
    @school = @group.school
    @user = @school.user
  end

  def update
  end

  def create
  end

  def destroy
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
  	@user = User.find(params[:user])
  	redirect_to root_path unless @user == current_user
  end
end

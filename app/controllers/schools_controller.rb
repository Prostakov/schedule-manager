class SchoolsController < ApplicationController
  include ApplicationHelper
  before_filter :correct_user_create, only: [:create]
  before_filter :correct_user, only: [:update, :destroy, :edit]

  def show
  	@school = School.find_by_slug(params[:id])
  end

  def create
  	@school = @user.schools.new(params[:school])
  	@school.save ? respond_obj(@school) : respond_obj_error(@school)
  end

  def update
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

class GroupsController < ApplicationController

  def show
    @group = Group.find_by_slug(params[:id])
    @school = @group.school
    @user = @school.user
  end
end

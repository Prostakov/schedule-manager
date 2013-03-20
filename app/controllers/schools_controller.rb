class SchoolsController < ApplicationController

  def show
  	@school = School.find_by_slug(params[:id])
  end
end

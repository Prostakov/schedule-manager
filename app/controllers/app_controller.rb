class AppController < ApplicationController

	def home
		if signed_in?
			@user = current_user
			@schedules = @user.schedules
			@schedule = @user.schedules.new
			@schools = @user.schools
			@school = @user.schools.new
		end
	end
end

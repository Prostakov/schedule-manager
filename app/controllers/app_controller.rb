class AppController < ApplicationController

	def home
		if signed_in?
			@user = current_user
			@schedules = @user.schedules
		end
	end
end

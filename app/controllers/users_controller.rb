class UsersController < ApplicationController
	before_filter :correct_user_pass_change, only: [:edit,:update]

	def new
		@user = User.new
	end

	def edit
	end

	def update
		if @user.authenticate(params[:user][:old_pass])
			@user.password = params[:user][:password]
			@user.password_confirmation = params[:user][:password_confirmation]
			if @user.save
				sign_in @user
				redirect_to root_path
			else
				render 'edit'
			end
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			redirect_to root_path
		else
			render 'new'
		end
	end

	private

	def correct_user_pass_change
		@user = User.find(params[:id])
		unless @user == current_user
			redirect_to root_path
		end
	end
end

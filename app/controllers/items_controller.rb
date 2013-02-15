class ItemsController < ApplicationController
	before_filter :correct_user_create, only: :create

	def create
		@item = @schedule.items.create(params[:item])
		respond_to do |format|
			format.hmtl {redirect_to @schedule}
			format.json { render json: @item.to_json }
		end
	end

	def show
	end

	def destroy
	end

	private

	def correct_user_create
		@schedule = Schedule.find(params[:schedule])
		@user = @schedule.user
		unless  @user == current_user
			redirect_to root_path
		end
	end
end

class ItemsController < ApplicationController
	before_filter :correct_user_create, only: :create
	before_filter :correct_user, only: [:update, :edit, :destroy]

	def create
		@item = @schedule.items.new(params[:item])
		if @item.save
			respond_to do |format|
				format.html { redirect_to @schedule }
				format.json { render json: @item.to_json }
			end
		else
			respond_to do |format|
				format.html { redirect_to @schedule }
				format.json { render json: 'Error'.to_json }
			end
		end
	end

	def show
	end

	def update
		if @item.update_attributes(params[:item])
			redirect_to_schedule @schedule
		else
			render 'edit'
		end
	end

	def edit
	  @item = Item.find(params[:id])
	  @schedule = @item.schedule
	  respond_to do |format|
	  	format.html
	    format.js
	  end
	end

	def destroy
		@item.destroy
		redirect_to_schedule @schedule
	end

  private

  def correct_user_create
    @schedule = Schedule.find(params[:schedule])
    @user = belongs_to_school?(@schedule) ? @schedule.group.school.user : @schedule.user
    unless  @user == current_user
      redirect_to root_path
    end
  end

  def correct_user
    @item = Item.find(params[:id])
    @schedule = @item.schedule
    @user = belongs_to_school?(@schedule) ? @schedule.group.school.user : @schedule.user
    unless @user == current_user
      redirect_to root_path
    end
  end
end

class AddLesson3ToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :lesson3, :string
  end
end

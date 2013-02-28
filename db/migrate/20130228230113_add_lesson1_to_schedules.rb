class AddLesson1ToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :lesson1, :string
  end
end

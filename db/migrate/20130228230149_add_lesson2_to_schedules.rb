class AddLesson2ToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :lesson2, :string
  end
end

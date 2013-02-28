class AddLesson4ToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :lesson4, :string
  end
end

class AddLesson5ToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :lesson5, :string
  end
end

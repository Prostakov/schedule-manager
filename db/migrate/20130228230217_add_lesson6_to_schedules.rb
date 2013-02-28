class AddLesson6ToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :lesson6, :string
  end
end

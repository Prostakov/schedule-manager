class AddWeeksToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :weeks, :boolean, default: false
  end
end

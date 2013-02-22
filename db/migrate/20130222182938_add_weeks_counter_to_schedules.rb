class AddWeeksCounterToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :weeks_counter, :boolean, default: false
  end
end

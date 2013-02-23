class AddWeeksCountToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :weeks_count, :integer
  end
end

class RemoveDayFromSchedules < ActiveRecord::Migration
  def up
  	remove_column :schedules, :day
  end

  def down
  end
end

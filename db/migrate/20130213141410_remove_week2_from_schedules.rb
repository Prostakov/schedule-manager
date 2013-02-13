class RemoveWeek2FromSchedules < ActiveRecord::Migration
  def up
  	remove_column :schedules, :week2
  end

  def down
  end
end

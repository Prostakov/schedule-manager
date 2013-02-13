class RemoveWeek1FromSchedules < ActiveRecord::Migration
  def up
  	remove_column :schedules, :week1
  end

  def down
  end
end

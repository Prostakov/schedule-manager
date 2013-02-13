class RemovePositionFromSchedules < ActiveRecord::Migration
  def up
  	remove_column :schedules, :position
  end

  def down
  end
end

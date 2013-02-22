class AddLocalTimeToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :local_time, :integer
  end
end

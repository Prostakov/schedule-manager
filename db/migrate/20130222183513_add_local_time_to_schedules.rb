class AddLocalTimeToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :local_time, :string, default: '+00:00'
  end
end

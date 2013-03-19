class AddGroupidToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :group_id, :integer
  end
end

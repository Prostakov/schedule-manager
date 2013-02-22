class AddSlugToSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :slug, :string
  end
end

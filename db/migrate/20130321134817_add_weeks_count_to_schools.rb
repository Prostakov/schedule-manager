class AddWeeksCountToSchools < ActiveRecord::Migration
  def change
  	add_column :schools, :weeks_count, :integer
  end
end

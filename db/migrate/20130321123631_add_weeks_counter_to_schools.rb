class AddWeeksCounterToSchools < ActiveRecord::Migration
  def change
  	add_column :schools, :weeks_counter, :boolean, default: false
  end
end

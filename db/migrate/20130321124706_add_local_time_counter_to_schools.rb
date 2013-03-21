class AddLocalTimeCounterToSchools < ActiveRecord::Migration
  def change
  	add_column :schools, :local_time, :string, default: '+00:00'
  end
end

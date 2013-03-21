class AddLessonsColumnsToSchools < ActiveRecord::Migration
  def change
  	add_column :schools, :lesson1, :string
  	add_column :schools, :lesson2, :string
  	add_column :schools, :lesson3, :string
  	add_column :schools, :lesson4, :string
  	add_column :schools, :lesson5, :string
  	add_column :schools, :lesson6, :string
  end
end

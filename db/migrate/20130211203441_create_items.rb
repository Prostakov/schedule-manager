class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :teacher
      t.string :location
      t.string :position
      t.string :day
      t.integer :schedule_id
      t.boolean :week1
      t.boolean :week2

      t.timestamps
    end
  end
end

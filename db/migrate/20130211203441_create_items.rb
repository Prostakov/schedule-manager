class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :teacher
      t.string :location
      t.integer :position
      t.integer :day
      t.integer :schedule_id
      t.boolean :week1, default: false
      t.boolean :week2, default: false

      t.timestamps
    end
  end
end

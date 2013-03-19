class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :slug
      t.integer :user_id

      t.timestamps
    end
  end
end

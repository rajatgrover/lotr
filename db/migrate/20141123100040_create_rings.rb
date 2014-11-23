class CreateRings < ActiveRecord::Migration
  def change
    create_table :rings do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :updated_by

      t.timestamps
    end
  end
end

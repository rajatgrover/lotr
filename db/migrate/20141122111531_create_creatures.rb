class CreateCreatures < ActiveRecord::Migration
  def change
    create_table :creatures do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.boolean :is_alive, :boolean, :default=>1
      t.boolean :has_ring, :boolean, :default=>0

      t.timestamps
    end
  end
end

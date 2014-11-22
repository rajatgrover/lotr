class CreateCreatureHistories < ActiveRecord::Migration
  def change
    create_table :creature_histories do |t|
      t.integer :event_log_id, null: false
      t.integer :creature_id, null: false
      t.float :latitude
      t.float :longitude
      t.boolean :is_alive, :boolean, :default=>1
      t.boolean :has_ring, :boolean, :default=>0
      t.timestamp :created_at

    end
  end
end

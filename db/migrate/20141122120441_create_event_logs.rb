class CreateEventLogs < ActiveRecord::Migration
  def change
    create_table :event_logs do |t|
      t.string :event
      t.string :annotation
      t.integer :reference_id, null: false
      t.string :reference_type, null: false
      t.timestamp :created_at
      t.integer :created_by

    end
    add_index :event_logs, :reference_id
  end
end

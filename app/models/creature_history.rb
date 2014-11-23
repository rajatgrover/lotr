class CreatureHistory < ActiveRecord::Base
  attr_accessible :created_at, :creature_id, :event_log_id, :has_ring, :is_alive, :latitude, :longitude
  validates_presence_of :creature_id, :event_log_id

  belongs_to :event_log
  belongs_to :creature
end

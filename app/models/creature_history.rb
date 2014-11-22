class CreatureHistory < ActiveRecord::Base
  attr_accessible :created_at, :creature_id, :event_log_id, :has_ring, :is_alive, :latitude, :longitude
end

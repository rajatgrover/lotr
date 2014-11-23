class EventLog < ActiveRecord::Base
  attr_accessible :annotation, :created_at, :created_by, :event, :reference_id, :reference_type
    validates_presence_of :reference_id, :reference_type
    belongs_to :reference, polymorphic: true
    belongs_to :creator, class_name: Creature, foreign_key: :created_by, primary_key: 'id'

    has_many :creature_histories
    after_create :snapshot 

    def snapshot
    	Creature.all.each do |c|
    		self.creature_histories << CreatureHistory.create(event_log_id: self.id, creature_id: c.id, latitude: c.latitude, longitude: c.longitude, is_alive: c.is_alive, has_ring: c.has_ring)
    	end
    end
end


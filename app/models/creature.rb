class Creature < ActiveRecord::Base
  attr_accessible :has_ring, :is_alive, :latitude, :longitude, :name
  attr_accessor :current_event, :updated_by
  validates_presence_of :latitude, :longitude, :name

  has_many :history, class_name: CreatureHistory.name, foreign_key: 'creature_id'
  has_many :event_logs, class_name: EventLog.name, as: :reference

  #before_save :check_ring_creature
  after_create :check_ring_and_create_event_log
  after_update :create_event_log
  after_save :fix_ring_position

  def check_ring_and_create_event_log
    self.has_ring = true if !self.has_ring? && self.close_to_ring? && Ring.instance.alone?
    create_event_log
  end

  def close_to_ring?
    r = Ring.instance
    self.latitude == r.latitude && self.longitude == r.longitude
  end
  def check_ring_creature
    #cs = Creature.where(has_ring: true)
    #rc = cs.first
    #if !rc.blank? && has_ring_changed? && :has_ring == true
    #  rc.update_attribute(:has_ring, false)
    #end
    #if !is_alive? && has_ring?
    #  fc = Creature.where(is_alive: true, latitude: self.latitude, longitude: self.longitude).first
    #  if fc.blank?
    #    raise Exception.new("Ring is alone.")
    #  else
    #    fc.update_attribute(:has_ring, true)
    #  end
    #end
  	# if cs.count != 1
  	# 	errors.add(:has_ring, "Ring must be assign to exactly one creature.")
  	# elsif rc.latitude != Ring.instance.latitude || rc.longitude == Ring.instance.longitude
  	# 	errors.add(:has_ring, "Ring position shoould be matched with the creature which has it.")
  	# end
  end

  def create_event_log
    self.current_event = Creature.event[:comes_in] if self.current_event.blank?
    el_cid = self.id
    el_cid = self.updated_by if self.current_event == :dead && !self.updated_by.blank?
  	self.event_logs << EventLog.create(event: self.current_event, annotation: "#{self.name} #{self.current_event}.", reference_id: self.id, reference_type: self.class.name, created_by: el_cid)
  end

  def fix_ring_position
    r = Ring.instance
    if self.has_ring?
      if self.is_alive?
        if !r.alone? && self != r.creature
          r.creature.current_event = self.current_event
          r.creature.updated_by = self.id
          r.creature.update_attribute(:has_ring, false)
        end
        r.position(self.latitude, self.longitude, self.id)
      elsif !self.updated_by.blank?
        k = Creature.where(id: self.updated_by).first
        if k.close_to_ring?
          r.position(k.latitude, k.longitude, k.id)
        else
          rc = Creature.where(is_alive: true, latitude: r.latitude, longitude: r.longitude).first
          r.update_attribute(:updated_by, rc.blank? ? -1 : rc.id)
        end
      else
        rc = Creature.where(is_alive: true, latitude: r.latitude, longitude: r.longitude).first
        r.update_attribute(:updated_by, rc.blank? ? -1 : rc.id)
      end
    end
  end

  def update_position lat, lon
    self.latitude = lat
    self.longitude = lon
    self.save!
  end

  def update_death kid
    self.updated_by = kid
    self.update_attribute(:is_alive, false)
  end

  def update_ring_creature
    self.update_attribute(:has_ring, true) if self.is_alive?
  end

  class << self
  	attr_reader :event

    def ring_creature
      Creature.where(is_alive: true, has_ring: true).first
    end
  end

  @event = {
  	comes_in: "Comes In",
  	goes_away: "Goes Away",
  	receive_ring: "Receive Ring",
  	died: "Died",
  	change_position: "Change Position"
  }.freeze

end

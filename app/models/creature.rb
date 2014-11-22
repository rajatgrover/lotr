class Creature < ActiveRecord::Base
  attr_accessible :has_ring, :is_alive, :latitude, :longitude, :name

  validates :name,  :presence => true
  validates :latitude,  :presence => true
  validates :longitude,  :presence => true
end

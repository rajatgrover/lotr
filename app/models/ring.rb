class Ring < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :updated_by
  belongs_to :creature, class_name: Creature, foreign_key: :updated_by, primary_key: 'id'

  def alone?
    updated_by == -1
  end

  def self.instance
    @@ring
  end

  def position(lat, lon, cid)
    self.latitude = lat.to_f
    self.longitude = lon.to_f
    self.updated_by = cid
    self.save!
  end

  @@ring = Ring.first
  private_class_method :new
end

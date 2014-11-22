class EventLog < ActiveRecord::Base
  attr_accessible :annotation, :created_at, :created_by, :event, :reference_id, :reference_type
end

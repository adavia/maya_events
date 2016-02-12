class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.join_event(user_id, event_id, state)
    self.create(user_id: user_id, event_id: event_id, state: state)
  end
end

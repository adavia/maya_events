class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: "User"

  validates :title, presence: true
end

class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: "User"

  validates :title, presence: true
  validates :title, length: { minimum: 10 }
  validates :description, presence: true
  validates :location, presence: true
  validate :start_date_cannot_be_minor_than_today
  validate :end_date_cannot_be_minor_than_start_date

  def start_date_cannot_be_minor_than_today
    if start_date < Time.now
      errors.add(:start_date, "Start date can't be minor than current date")
    end
  end

  def end_date_cannot_be_minor_than_start_date
    if end_date < start_date
      errors.add(:end_date, "End date can't be minor than start date")
    end
  end
end

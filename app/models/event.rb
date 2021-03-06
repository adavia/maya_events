class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: "User"
  has_and_belongs_to_many :tags, uniq: true
  attr_accessor :tag_names

  has_many :attendances
  has_many :users, through: :attendances

  validates :title, presence: true
  validates :title, length: { minimum: 10 }
  validates :description, presence: true
  validates :location, presence: true
  validate :start_date_cannot_be_minor_than_today
  validate :end_date_cannot_be_minor_than_start_date

  geocoded_by :location
  after_validation :geocode, :if => :location_changed?

  default_scope { order(created_at: :desc) }

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

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end

  def self.search(name)
    Tag.where("name like ?", "%#{name}%").first.events
  end
end

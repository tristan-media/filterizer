class Event < ActiveRecord::Base
  validates :venue, :title, :start_date, :end_date, presence: true
  belongs_to :venue

  scope :opening_soon, lambda {
    includes(:venue)
      .includes(venue: :neighborhood)
      .where('opening_date >= ? AND opening_date <= ?',
             Time.zone.now.to_date.to_s,
             10.days.from_now.to_date.to_s).order("opening_date, opening_start_time")
  }

  scope :opening_today, lambda {
    date = Time.zone.now.to_date.to_s
    where('opening_date = ? or (opening_date IS NULL and start_date = ?)',
          date, date).order("opening_start_time")
  }

  scope :not_tweeted, -> { where(tweeted: false) }

  # for rails admin
  after_initialize do
    if new_record?
      self.opening_start_time ||= '18:00'
      self.opening_end_time ||= '20:00'
    end
  end

  def url
    website.presence || venue.website
  end

  def venue_name
    venue.try(:name)
  end

  def tweeted!
    update(tweeted: true)
  end

  # open now, organized by hood
  def self.open_now
    list = []
    today = Time.zone.now.to_date.to_s

    Neighborhood.order("name").each do |neighborhood|
      events = Event.joins(:venue).where("venues.neighborhood_id = ? and start_date <= ? and end_date >= ?",
                                         neighborhood.id, today, today)
                    .includes(:venue).order("end_date")
                    .includes(venue: :neighborhood)

      list << [neighborhood.name, events] unless events.empty?
    end
    list
  end

  def self.current
    today = Time.zone.now.to_date.to_s
    Event.joins(:venue).where("opening_date = ? or (start_date <= ? and end_date >= ?)",
                              today, today, today).order("created_at").uniq
  end
end

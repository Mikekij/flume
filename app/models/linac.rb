class Linac < ActiveRecord::Base

  has_many :events
  belongs_to :user_group
  

  def format_events_data
    #init blank results array
    results = []
    events_data = []

    #Add linac name
    results << self.name

    #get all the events for this linac
    events = self.events

    events.each do |e|
      this_events_data = [e.starttime.to_i * 1000,e.duration / 60] #this encodes starttime in epoch seconds to milliseconds, and duration in min
      events_data << this_events_data
    end

    results << events_data

    return results
  end

  def downtime_percentage
    #this is not a db-efficient way to do this.
    @events = Event.all

    this_linacs_downtime = 0
    total_downtime = 0

    self.events.each do |e|
      this_linacs_downtime = this_linacs_downtime + e.duration
    end

    @events.each do |e|
      total_downtime = total_downtime + e.duration
    end

    return (this_linacs_downtime.to_f / total_downtime.to_f) * 100
  end

  def self.sorted_by_downtime
    Linac.all.sort_by(&:downtime_percentage).reverse!
  end
end

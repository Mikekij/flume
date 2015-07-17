class Event < ActiveRecord::Base

  before_create :calculate_duration

  belongs_to :linac

  def calculate_duration
    duration = (self.endtime - self.starttime).to_i
    self.duration = duration
  end

  def self.pareto_data
    @events = Event.all.order('duration DESC')

    total_downtime = 0 #in seconds

    results_array = []
    bargraph_data = []
    percentage_data = []

    @events.each do |e|
      total_downtime = total_downtime + e.duration
    end

    accumulated_downtime = 0

    @events.each do |e|
      bargraph_data << [e.linac.name ,e.starttime.to_i * 1000, e.duration / 60]
      accumulated_downtime = accumulated_downtime + e.duration
      percentage_data << [((e.duration.to_f / total_downtime.to_f) * 100), (accumulated_downtime.to_f / total_downtime.to_f) * 100] #reports accumulated_downtime in min
    end

    results_array << bargraph_data
    results_array << percentage_data

    return results_array
  end

end

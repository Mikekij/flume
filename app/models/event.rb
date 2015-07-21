class Event < ActiveRecord::Base

  before_create :calculate_duration
  before_save :calculate_duration

  belongs_to :linac

  def calculate_duration
    if !self.endtime.nil?
      duration = (self.endtime - self.starttime).to_i
      self.duration = duration
    end
  end

  def self.pareto_data(events)
    @events = events.reorder('duration DESC')

    total_downtime = 0 #in seconds

    results_array = []
    bargraph_data = []
    percentage_data = []

    @events.each do |e|
      total_downtime = total_downtime + e.duration unless e.duration.nil?
    end

    accumulated_downtime = 0

    @events.each do |e|
      if !e.duration.nil?
        bargraph_data << [e.linac.name ,e.starttime.to_i * 1000, e.duration.to_f / 60]
        accumulated_downtime = accumulated_downtime + e.duration
        percentage_data << [((e.duration.to_f / total_downtime.to_f) * 100), (accumulated_downtime.to_f / total_downtime.to_f) * 100] #reports accumulated_downtime in min
      end
    end

    results_array << bargraph_data
    results_array << percentage_data

    return results_array
  end

  def self.area_data(linac)
    @events = linac.events.reorder('duration DESC')

    results_array = [linac.name]
    area_data = []

    @events.each do |e|
      if !e.duration.nil?
        area_data << (e.duration.to_f / 60) #reports downtime in minutes
      end
    end

    results_array << area_data

    return results_array
  end

  def self.generate_random_data(days_ago)
    @linacs = Linac.all

    #randomly select linac
    linac_index = rand(@linacs.count)

    #for each linac
    @linacs.each do |l|
      #random "breakdown" coefficient
      if l.name.include? "Elekta"
        downtime_multiplier = 6
      else
        downtime_multiplier = rand(6)
      end

      #start from days_ago
      days_ago.times do |d|
        is_there_delay_today = rand(6) #creates a 1/n probability of a down time.
        if is_there_delay_today == 1 #if we decide there is a delay today
          @event = Event.new
          @event.linac_id = l.id
          @event.created_by_user_id = User.first.id #sets this to first user.

          @event.starttime = DateTime.now - d #sets the startup d days ago

          random_duration = rand(60) * (downtime_multiplier + 1) #random num of minutes less than 1 hours
          @event.endtime = @event.starttime + (random_duration.to_f / 60).hours

          @event.save! #this will also calcuate the duration
        end
      end

    end
  end

  def self.clear_all
    Event.all.each do |e|
      e.destroy
    end
  end

end

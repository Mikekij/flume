class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all.order('created_at DESC')

    #will need to scope this by usergroup in the future
    @linacs = Linac.sorted_by_downtime
    @events_data_array = []

    @linacs.each do |l|
      results = l.format_events_data
      @events_data_array << results
    end

    @pareto_data = Event.pareto_data

    @linac_array = []

    @linacs.each do |l|
      @linac_array << l.name
    end

  end

end

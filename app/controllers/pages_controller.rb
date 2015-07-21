class PagesController < ApplicationController
  before_action :authenticate_user!

  def index

    @user_group = current_user.user_group
    @new_event = Event.new
  #  @events = Event.all.order('created_at DESC')
  #  @events = @user_group.linacs.joins(:events).where(:events => {linac_id => params[:id]})

    #will need to scope this by usergroup in the future
    if current_user.admin?
      @linacs = Linac.all.sorted_by_downtime
    else
      @linacs = @user_group.linacs.sorted_by_downtime
    end

    if current_user.admin?
      @events = Event.all.order('starttime DESC').paginate(:page => params[:page] || 1, :per_page => 10)
    else
      @events = @user_group.events.order('starttime DESC').paginate(:page => params[:page] || 1, :per_page => 10)
    end

    @events_data_array = []

    @linacs.each do |l|
      results = l.format_events_data
      @events_data_array << results
    end

    @pareto_data = Event.pareto_data(@events)
    @area_data = []

    @linacs.each do |l|
      linac_data = Event.area_data(l)
      @area_data << linac_data
    end

    @linac_array = []

    @linacs.each do |l|
      @linac_array << l.name
    end

  end

end

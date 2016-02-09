class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = "Event has been created."
      redirect_to @event
    else
      flash.now[:alert] = "Event has not been created."
      render "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:notice] = "Event has been updated."
      redirect_to @event
    else
      flash.now[:alert] = "Event has not been updated."
      render "edit"
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :start_date,
        :end_date, :location, :agenda, :address)
    end
end

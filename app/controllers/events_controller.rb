class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, 
    :update, :destroy, :join, :accept_request, :reject_request]

  before_action :set_event, only: [:show, :edit, :update, :destroy,
    :join, :accept_request, :reject_request]

  before_action :event_owner!, only: [:edit, :update, :destroy,
    :accept_request, :reject_request]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.organized_events.build(event_params)

    if @event.save
      flash[:notice] = "Event has been created."
      redirect_to @event
    else
      flash.now[:alert] = "Event has not been created."
      render "new"
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event has been updated."
      redirect_to @event
    else
      flash.now[:alert] = "Event has not been updated."
      render "edit"
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = "Event has been deleted."
    redirect_to events_path
  end

  def search
    if params[:q].present?
      @events = Event.search(params[:q])
    else
      @events = Event.all
    end

    render "events/index"
  end

  def my_events
    @events = current_user.organized_events

    render "events/index"
  end

  def join
    @attendance = Attendance.join_event(current_user.id,
      params[:id], "request_sent")

    @attendance.save

    flash[:notice] = "Your request has been sent to join this event."
    redirect_to @event
  end

  def accept_request
    @attendance = Attendance.find(params[:attendance_id]) rescue nil
    @attendance.accept!

    @attendance.save

    flash[:notice] = "User accepted to join event."
    redirect_to @event
  end

  def reject_request
    @attendance = Attendance.find(params[:attendance_id]) rescue nil
    @attendance.reject!

    @attendance.save

    flash[:notice] = "User rejected to join event."
    redirect_to @event
  end

  private
    def set_event
      @event = Event.find(params[:id])
      rescue ActiveRecord::RecordNotFound

      flash[:alert] = "The event you were looking for could not be found."
      redirect_to root_path
    end

    def event_owner!
      authenticate_user!

      if @event.organizer.id != current_user.id
        flash[:alert] = "You do not have enough permissions to do this."
        redirect_to @event
      end
    end

    def event_params
      params.require(:event).permit(:title, :description, :start_date,
        :end_date, :location, :address, :tag_names)
    end
end

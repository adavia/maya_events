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
    @request = @event.attendances.cancel(current_user.id).first
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.organized_events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { 
          flash[:notice] = "Event has been created."
          redirect_to @event 
        }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { 
          flash.now[:alert] = "Event has not been created."
          render action: "new"
        }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { 
          flash[:notice] = "Event has been updated."
          redirect_to @event 
        }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { 
          flash.now[:alert] = "Event has not been updated."
          render action: "edit"
        }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
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

    if !request.xhr?
      flash[:notice] = "Your request has been sent to join this event."
      redirect_to @event
    else
      render partial: "events/request", locals: { request: @attendance }
    end
  end

  def accept_request
    @attendance = Attendance.find(params[:attendance_id]) rescue nil
    @attendance.accept!

    @attendance.save

    if !request.xhr?
      flash[:notice] = "User accepted to join event."
      redirect_to @event
    else
      render layout: false
    end
  end

  def reject_request
    @attendance = Attendance.find(params[:attendance_id]) rescue nil
    @attendance.reject!

    @attendance.save

    if !request.xhr?
      flash[:notice] = "User rejected to join event."
      redirect_to @event
    else
      render layout: false
    end
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

class AttendancesController < ApplicationController
  before_action :set_event

  before_action :authenticate_user!, only: [:destroy]

  before_action :set_attendance, only: [:destroy]

  before_action :attendance_user!, only: [:destroy]

  def destroy
    @attendance.destroy
    if !request.xhr?
      flash[:notice] = "You have been removed from the event."
      redirect_to @attendance.event
    else
      render partial: "events/request", locals: { request: nil, event: @event }
    end
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_attendance
      @attendance = Attendance.find(params[:id])
      rescue ActiveRecord::RecordNotFound

      flash[:alert] = "This attendance does not exists."
      redirect_to root_path
    end

    def attendance_user!
      authenticate_user!

      if @attendance.user.id != current_user.id
        flash[:alert] = "You do not have enough permissions to do this."
        redirect_to @attendance.event
      end
    end
end

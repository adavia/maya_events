class TagsController < ApplicationController
  def remove
    @event = Event.find(params[:event_id])
    @tag = Tag.find(params[:id])

    if user_signed_in? && @event.organizer.id == current_user.id
      @event.tags.destroy(@tag)
      head :ok
    else
      head :unauthorized
    end
  end
end

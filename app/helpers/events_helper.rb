module EventsHelper
  def check_user_request(req)
    req.each do |r|
      if r.user.id == current_user.id 
        if r.state == "request_sent" || r.state == "accepted" || r.state == "rejected"
          return link_to "Cancel joined request", attendance_path(r), method: :delete,
            class: "btn btn-danger btn-sm", role: "button"
        end
      end
    end
    link_to "Join event", join_event_path, 
      class: "btn btn-success btn-sm", role: "button"
  end
end

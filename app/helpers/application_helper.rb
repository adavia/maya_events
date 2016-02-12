module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Riviera Events").join(" - ")
      end
    end
  end

  def active_link(path)
    if current_page? path
      "active"
    end
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end

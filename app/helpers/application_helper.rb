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
end

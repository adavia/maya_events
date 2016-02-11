module CapybaraFinders
  def tag(content)
    find("div.tag", text: content)
  end
end

RSpec.configure do |c|
  c.include CapybaraFinders, type: :feature
end
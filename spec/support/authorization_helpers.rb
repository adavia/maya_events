module AuthorizationHelpers
  def event_owner!(user, event) 
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
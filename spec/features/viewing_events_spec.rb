require "rails_helper"

RSpec.feature "Users can view events" do
  scenario "with the event details" do
    event = FactoryGirl.create(:event, title: "Pool Party")
    visit "/"
    click_link "Pool Party"
    expect(page.current_url).to eq event_url(event)
  end
end
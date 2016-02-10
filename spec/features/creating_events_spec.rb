require "rails_helper"

RSpec.feature "Organizers can create new events" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    
    visit "/"
    click_link "New Event"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "Pool Party"
    fill_in "Description", with: "Saturday pool party event for friends"
    click_button "Create Event"

    expect(page).to have_content "Event has been created."

    event = Event.find_by(title: "Pool Party")
    expect(page.current_url).to eq event_url(event)

    title = "Pool Party - Events - Riviera Events"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    click_button "Create Event"

    expect(page).to have_content "Event has not been created."
    expect(page).to have_content "Title can't be blank"
  end
end
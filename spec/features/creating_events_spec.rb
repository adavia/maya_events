require "rails_helper"

RSpec.feature "Organizers can create new events" do
  scenario "with valid attributes" do
    visit "/"

    click_link "New Event"

    fill_in "Title", with: "Pool Party"
    fill_in "Description", with: "Saturday pool party event for friends"
    click_button "Create Event"

    expect(page).to have_content "Event has been created."
  end
end
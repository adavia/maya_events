require "rails_helper"

RSpec.feature "Organizers can delete events" do
  scenario "successfully" do
    FactoryGirl.create(:event, title: "Pool Party")

    visit "/"
    click_link "Pool Party"
    click_link "Delete Event"

    expect(page).to have_content "Event has been deleted."
    expect(page.current_url).to eq events_url
    expect(page).to have_no_content "Pool Party"
  end
end
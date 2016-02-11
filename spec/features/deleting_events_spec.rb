require "rails_helper"

RSpec.feature "Organizers can delete events" do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, organizer: user) }

  before do
    login_as(user)
    visit event_path(event)
  end

  scenario "successfully" do
    click_link "Delete Event"

    expect(page).to have_content "Event has been deleted."
    expect(page.current_url).to eq events_url
  end
end
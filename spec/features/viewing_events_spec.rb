require "rails_helper"

RSpec.feature "Users can view events" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event) do
    FactoryGirl.create(:event, title: "Pool Party in forest", organizer: user)
  end

  before do
    login_as(user)
    visit "/" 
  end

  scenario "with the event details" do
    click_link "Pool Party in forest"
    expect(page.current_url).to eq event_url(event)
  end

  scenario "created themselves" do
    click_link "My events"
    expect(page).to have_content "Pool Party in forest"
  end
end
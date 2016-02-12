require "rails_helper"

RSpec.feature "Users can join events" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event) do
    FactoryGirl.create(:event, title: "Pool Party in forest", organizer: user)
  end

  before do
    login_as(user)
    visit "/"
  end

  scenario "when clicking the join button" do  
    click_link "Pool Party in forest"
    click_link "Join event"
    expect(page).to have_content "Your request has been sent to join this event."
  end
end
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
    expect(page).to have_content "Cancel joined request"
    within(:css, "ul.event-requests", match: :first) do
      expect(page).to have_content user.email
    end
  end
end
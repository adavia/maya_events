require "rails_helper"

RSpec.feature "Users can cancel event requests" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event) do
    FactoryGirl.create(:event, title: "Pool Party in forest", organizer: user)
  end
  let!(:attendance) do
    FactoryGirl.create(:attendance, user: user, event: event)
  end

  before do
    login_as(user)
    visit "/"
    click_link "Pool Party in forest"
  end

  scenario "when clicking the cancel joined request button" do  
    click_link "Cancel joined request"
    expect(page).to have_content "You have been removed from the event."
  end
end
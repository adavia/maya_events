require "rails_helper"

RSpec.feature "Organizers can manage user requests" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event) do
    FactoryGirl.create(:event, title: "Pool Party in forest", organizer: user)
  end

  before do
    login_as(user)
    visit "/"
    click_link "Pool Party in forest"
    click_link "Join event"
  end

  scenario "to accept users" do  
    click_link "Accept"
    expect(page).to have_content "User accepted to join event."
  end

  scenario "to reject users" do
    click_link "Reject"
    expect(page).to have_content "User rejected to join event."
  end
end
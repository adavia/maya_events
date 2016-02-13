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
    within all("ul.event-requests").first do
      expect(page).to_not have_content user.email
    end
  end

  scenario "to reject users" do
    click_link "Reject"
    expect(page).to have_content "User rejected to join event."
    within all("ul.event-requests").last do
      expect(page).to_not have_content user.email
    end
  end
end
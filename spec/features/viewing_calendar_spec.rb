require "rails_helper"

RSpec.feature "Organizers can view their calendar events" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:event) do
    FactoryGirl.create(:event, title: "Pool Party in forest", organizer: user)
  end

  before do
    login_as(user)
    visit "/" 
  end

  scenario "with the default date" do
    click_link "Show calendar"
    expect(page).to have_content Time.now.strftime("%B %e")
    expect(page).to have_content "Pool Party in forest"
  end

  scenario "clicking previous link" do
    click_link "Show calendar"
    click_link "Previous"
    expect(page).to have_content (Time.now - 1.day).strftime("%B %e")
  end

  scenario "clicking next link" do
    click_link "Show calendar"
    click_link "Next"
    expect(page).to have_content (Time.now + 8.days).strftime("%B %e")
  end
end



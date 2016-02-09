require "rails_helper"

RSpec.feature "Organizers can edit existing events" do
  before do
    FactoryGirl.create(:event, title: "Pool Party")

    visit "/"
    click_link "Pool Party"
    click_link "Edit Event"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "Pool Party in my house"
    click_button "Update Event"

    expect(page).to have_content "Event has been updated."
    expect(page).to have_content "Pool Party in my house"
  end

  scenario "when providing invalid attributes" do
    fill_in "Title", with: ""
    click_button "Update Event"

    expect(page).to have_content "Event has not been updated."
  end
end
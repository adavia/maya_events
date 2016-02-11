require "rails_helper"

RSpec.feature "Organizers can delete unwanted tags from an event" do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) do
    FactoryGirl.create(:event, tag_names: "ThisTagMustDie", organizer: user)
  end

  before do
    login_as(user)
    visit event_path(event)
  end

  scenario "successfully", js: true do
    within tag("ThisTagMustDie") do
      click_link "remove"
    end
    expect(page).to_not have_content "ThisTagMustDie"
  end
end
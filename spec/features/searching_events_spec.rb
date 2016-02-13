require "rails_helper"

RSpec.feature "Organizers can search for events matching specific tags" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event) do
    FactoryGirl.create(:event, title: "Awesome party in the beach",
      organizer: user, tag_names: "iteration_1")
  end

  before do
    login_as(user)
    visit event_path(event)
  end

  scenario "searching by tag" do
    fill_in "Search", with: "iteration_1"
    click_button "Search"
    within("#events") do
      expect(page).to have_content "Awesome party in the beach"
    end
  end

  scenario "when clicking on a tag" do
    click_link "iteration_1"

    within("#events") do
      expect(page).to have_content "Awesome party in the beach"
    end
  end
end
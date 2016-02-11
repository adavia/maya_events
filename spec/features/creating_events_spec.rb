require "rails_helper"

RSpec.feature "Organizers can create new events" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    
    visit "/"
    click_link "New Event"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "Pool Party"
    fill_in "Description", with: "Saturday pool party event for friends"
    fill_in "Location", with: "Some location"

    select '2021', from: "event_start_date_1i"
    select 'January', from: "event_start_date_2i"
    select '5', from: "event_start_date_3i"
    select '10', from: "event_start_date_4i"
    select '30', from: "event_start_date_5i"

    select '2021', from: "event_end_date_1i"
    select 'February', from: "event_end_date_2i"
    select '5', from: "event_end_date_3i"
    select '09', from: "event_end_date_4i"
    select '30', from: "event_end_date_5i"

    click_button "Create Event"

    expect(page).to have_content "Event has been created."

    event = Event.find_by(title: "Pool Party")
    expect(page.current_url).to eq event_url(event)

    title = "Pool Party - Events - Riviera Events"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    click_button "Create Event"

    expect(page).to have_content "Event has not been created."
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
    expect(page).to have_content "Location can't be blank"
  end

  scenario "with an invalid title" do
    fill_in "Title", with: "It sucks"
    fill_in "Description", with: "This is odd"
    fill_in "Location", with: "Some location"
    click_button "Create Event"

    expect(page).to have_content "Event has not been created."
    expect(page).to have_content "Title is too short"
  end

  scenario "with an invalid start date" do
    fill_in "Title", with: "Pool Party"
    fill_in "Description", with: "This is odd"
    fill_in "Location", with: "Some location"
    
    select '2016', from: "event_start_date_1i"
    select 'January', from: "event_start_date_2i"
    select '5', from: "event_start_date_3i"
    select '10', from: "event_start_date_4i"
    select '30', from: "event_start_date_5i"

    click_button "Create Event"

    expect(page).to have_content "Event has not been created."
    expect(page).to have_content "Start date can't be minor than current date"
  end

  scenario "with an invalid end date" do
    fill_in "Title", with: "Pool Party"
    fill_in "Description", with: "This is odd"
    fill_in "Location", with: "Some location"

    select '2016', from: "event_start_date_1i"
    select 'February', from: "event_start_date_2i"
    select '5', from: "event_start_date_3i"
    select '10', from: "event_start_date_4i"
    select '30', from: "event_start_date_5i"

    select '2016', from: "event_end_date_1i"
    select 'February', from: "event_end_date_2i"
    select '5', from: "event_end_date_3i"
    select '09', from: "event_end_date_4i"
    select '30', from: "event_end_date_5i"

    click_button "Create Event"

    expect(page).to have_content "Event has not been created."
    expect(page).to have_content "End date can't be minor than start date"
  end

  scenario "with associated tags" do
    fill_in "Title", with: "Wow this is a new title"
    fill_in "Description", with: "My pages are ugly!"
    fill_in "Location", with: "Some location"

    select '2021', from: "event_start_date_1i"
    select 'January', from: "event_start_date_2i"
    select '5', from: "event_start_date_3i"
    select '10', from: "event_start_date_4i"
    select '30', from: "event_start_date_5i"

    select '2021', from: "event_end_date_1i"
    select 'February', from: "event_end_date_2i"
    select '5', from: "event_end_date_3i"
    select '09', from: "event_end_date_4i"
    select '30', from: "event_end_date_5i"

    fill_in "Tags", with: "browser visual"

    click_button "Create Event"

    expect(page).to have_content "Event has been created."
    within("#tags") do
    expect(page).to have_content "browser"
    expect(page).to have_content "visual"
    end
  end
end
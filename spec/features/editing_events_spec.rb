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
    fill_in "Description", with: "Sunday pool party event for friends"
    fill_in "Location", with: "Odd location"
    
    click_button "Update Event"

    expect(page).to have_content "Event has been updated."
    expect(page).to have_content "Pool Party in my house"
  end

  scenario "when providing invalid attributes" do
    fill_in "Title", with: ""
    fill_in "Description", with: ""
    fill_in "Location", with: ""
    click_button "Update Event"

    expect(page).to have_content "Event has not been updated."
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
    expect(page).to have_content "Location can't be blank"
  end

  scenario "with an invalid title" do
    fill_in "Title", with: "It sucks"
    fill_in "Description", with: "This is odd now"
    fill_in "Location", with: "Some location here"
    click_button "Update Event"

    expect(page).to have_content "Event has not been updated."
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

    click_button "Update Event"

    expect(page).to have_content "Event has not been updated."
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

    click_button "Update Event"

    expect(page).to have_content "Event has not been updated."
    expect(page).to have_content "End date can't be minor than start date"
  end
end
require "rails_helper"

RSpec.describe EventsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user, email: "something@hotmail.com") }

  before :each do
    sign_in user
  end

  it "handles a missing project correctly" do
    get :show, id: "not-here"

    expect(response).to redirect_to(root_path)

    message = "The event you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it "handles owner permission errors by redirecting to a safe place" do
    event = FactoryGirl.create(:event, title: "Some cool event",
      organizer: user_2)

    get :edit, id: event
    
    expect(response).to redirect_to(event)
    message = "You do not have enough permissions to do this."
    expect(flash[:alert]).to eq message
  end
end

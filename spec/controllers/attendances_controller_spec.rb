require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user, email: "something@hotmail.com") }
  let(:event) { FactoryGirl.create(:event) }

  before :each do
    sign_in user
  end

  it "handles a missing attendance correctly" do
    post :destroy, event_id: event, id: "not-here"

    expect(response).to redirect_to(root_path)

    message = "This attendance does not exists."
    expect(flash[:alert]).to eq message
  end

  it "handles owner permission errors by redirecting to a safe place" do
    event = FactoryGirl.create(:event, title: "Some cool event",
      organizer: user_2)

    attendance = FactoryGirl.create(:attendance, user: user_2, event: event)

    post :destroy, event_id: event, id: attendance
    
    expect(response).to redirect_to(event)
    message = "You do not have enough permissions to do this."
    expect(flash[:alert]).to eq message
  end
end

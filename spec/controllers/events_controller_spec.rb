require "rails_helper"

RSpec.describe EventsController, type: :controller do
  it "handles a missing project correctly" do
    get :show, id: "not-here"

    expect(response).to redirect_to(events_path)

    message = "The event you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
end

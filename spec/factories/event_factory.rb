FactoryGirl.define do
  factory :event do
    title "Example event"
    description "This is a description for the event"
    start_date Time.now + 2.days
    end_date Time.now + 10.days
    location "Cancun Quintana roo"
  end
end
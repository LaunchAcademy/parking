FactoryGirl.define do
  factory :parking_registration do
    first_name 'John'
    last_name 'Smith'
    email 'user@example.com'
    spot_number 5
    association :location
    parked_on { Date.today }
  end

  factory :location do
    sequence(:name) {|n| "Location #{n}" }
  end
end

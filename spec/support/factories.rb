FactoryGirl.define do
  factory :parking_registration do
    first_name 'John'
    last_name 'Smith'
    email 'user@example.com'
    spot_number 5
    parked_on { Date.today }
  end
end

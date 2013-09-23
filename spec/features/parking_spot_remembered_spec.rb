require 'spec_helper'

feature 'remember spot', %Q{
  As a parker
  I want to know what spot I parked in yesterday
  So that I can determine if I'm parking in the same spot
} do
  # Acceptance Criteria:
  # * If I parked yesterday, the system tells me where I parked yesterday
  #   when checking in.
  # * If I did not park yesterday, the system tells me that I did not park
  #   yesterday when checking in.

  scenario 'parked yesterday' do
    visit new_parking_registration_path
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Spot number', with: 5
    click_button 'Register'
    expect(page).to have_content('You registered successfully')

    reg = ParkingRegistration.last
    reg.parked_on = Date.yesterday
    reg.save!

    visit new_parking_registration_path
    expect(page).to have_content("Yesterday, you parked in spot #{reg.spot_number}")
  end
  scenario 'did not park yesterday' do
    visit new_parking_registration_path
    expect(page).to have_content("You did not park yesterday")
  end

end

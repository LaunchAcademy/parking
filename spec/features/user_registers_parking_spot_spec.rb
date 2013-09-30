require 'spec_helper'

feature "user registers spot", %Q{
  As a parker
  I want to register my spot with my name
  So that the parking company can identify my car
} do
  # Acceptance Criteria:

  # * I must specify a first name, last name, email, and parking spot number
  # * I must enter a valid parking spot number (the lot has spots identified as numbers 1-60)
  # * I must enter a valid email
  # * If I specify a parking spot that has already been checked in for the day, I am told I can't check in there.
  # * If I specify a spot that hasn't yet been parked in today, I am able to check in.

  # Also covers:
  # As a parker
  # I cannot check in to a spot that has already been checked in
  # So that two cars are not parked in the same spot

  scenario 'specifies valid information, registers spot' do
    #clear out mail deliveries
    ActionMailer::Base.deliveries = []

    prev_count = ParkingRegistration.count
    visit '/'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Spot number', with: 5
    click_button 'Register'
    expect(page).to have_content('You registered successfully')
    expect(ParkingRegistration.count).to eql(prev_count + 1)

    #expect email details pertaining to the confirmation
    expect(ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject('Parking Confirmation')
    expect(last_email).to deliver_to('user@example.com')
    expect(last_email).to have_body_text(/spot number 5/)
  end

  scenario 'attempts to register spot that is taken' do
    FactoryGirl.create(:parking_registration,
      spot_number: 24,
      parked_on: Date.today)

    prev_count = ParkingRegistration.count

    visit '/'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Spot number', with: 24
    click_button 'Register'

    expect(page).to_not have_content('You registered successfully')
    expect(page).to have_content('is already taken')
    expect(ParkingRegistration.count).to eql(prev_count)
  end


end

require 'spec_helper'

feature 'system remembers email', %Q{
  As a parker
  I want the system to remember my email
  So that I don't have to re-enter it
  } do
  # Acceptance Criteria:

  # * If I have previously checked in via the same web browser,
  #   my email is remembered so that I don't have to re-enter it
  # * If I have not previously checked in, the email address field
  #   is left blank
  #
  #   Refer to user_registers_parking_spot_spec for use case where
  #   the email is not going to be remembered

  scenario 'remember the email' do
    email = 'user@example.com'

    visit new_parking_registration_path
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Email', with: email
    fill_in 'Spot number', with: 5
    click_button 'Register'
    expect(page).to have_content('You registered successfully')

    visit new_parking_registration_path

    expect(page).to have_selector("input[value='#{email}']")
  end
end

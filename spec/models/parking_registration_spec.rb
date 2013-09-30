require 'spec_helper'

describe ParkingRegistration do
  it do
    should have_valid(:email).when(
      'user@example.com',
      'user+2@another.com'
    )
  end

  it do
    should_not have_valid(:email).when(
      nil,
      '',
      'foo'
    )
  end

  it do
    should have_valid(:first_name).when('John', 'Dan')
  end

  it do
    should_not have_valid(:first_name).when(
      nil,
      ''
    )
  end

  it do
    should have_valid(:last_name).when(
      'Smith',
      'Sun'
    )
  end

  it do
    should_not have_valid(:last_name).when(
      nil,
      ''
    )
  end

  it do
    should have_valid(:spot_number).when(
      5,
      20
    )
  end

  it do
    should_not have_valid(:spot_number).when(
      nil,
      0,
      61
    )
  end

  it do
    should have_valid(:parked_on).when(
      Date.today
    )
  end

  it do
    should_not have_valid(:parked_on).when(
      nil,
      ''
    )
  end

  describe 'parking' do
    it 'parks the car for today' do
      registration = FactoryGirl.build(:parking_registration, parked_on: nil)
      expect(registration.park).to eql(true)
      expect(registration.parked_on).to eql(Date.today)

    end

    it 'sends an email when parking is successful' do
      prev_mail_count = ActionMailer::Base.deliveries.count
      FactoryGirl.build(:parking_registration).park
      expect(ActionMailer::Base.deliveries.count).to eql(prev_mail_count + 1)
    end

    it 'only allows one registration in one spot per day' do
      prev_registration = FactoryGirl.create(:parking_registration)
      registration = FactoryGirl.build(:parking_registration,
        spot_number: prev_registration.spot_number,
        parked_on: prev_registration.parked_on)
      expect(registration.park).to be_false
      expect(registration).to_not be_valid
      expect(registration.errors[:spot_number]).to_not be_blank

    end
  end
end

require 'spec_helper'

describe ParkingRegistration do
  it do
    is_expected.to have_valid(:email).when(
      'user@example.com',
      'user+2@another.com'
    )
  end

  it { is_expected.to_not have_valid(:email).when(nil, '', 'foo') }

  it { is_expected.to have_valid(:first_name).when('John', 'Dan') }

  it { is_expected.to_not have_valid(:first_name).when(nil, '') }

  it { is_expected.to have_valid(:last_name).when('Smith', 'Sun') }

  it { is_expected.to_not have_valid(:last_name).when(nil, '') }

  it { is_expected.to have_valid(:spot_number).when(5, 20) }

  it { is_expected.to_not have_valid(:spot_number).when(nil, 0, 61) }

  it { is_expected.to have_valid(:parked_on).when(Date.today) }

  it { is_expected.to_not have_valid(:parked_on).when(nil, '') }

  describe 'parking' do
    it 'parks the car for today' do
      registration = FactoryGirl.build(:parking_registration, parked_on: nil)
      expect(registration.park).to eq(true)
      expect(registration.parked_on).to eq(Date.today)

    end

    it 'only allows one registration in one spot per day' do
      prev_registration = FactoryGirl.create(:parking_registration)
      registration = FactoryGirl.build(:parking_registration,
        spot_number: prev_registration.spot_number,
        parked_on: prev_registration.parked_on)
      expect(registration.park).to eq(false)
      expect(registration).to_not be_valid
      expect(registration.errors[:spot_number]).to_not be_blank

    end
  end
end

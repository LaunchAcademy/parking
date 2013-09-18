require 'spec_helper'

describe Location do
  it { should have_valid(:name).when('Winter Street', 'Summer Street')}
  it { should_not have_valid(:name).when('', nil)}

  describe 'uniqueness' do
    it 'requires that the name is unique' do
      old_location = FactoryGirl.create(:location)
      location = FactoryGirl.build(:location,
        name: old_location.name)
      expect(location).to_not be_valid
      expect(location.errors[:name]).to_not be_blank
    end
  end
end

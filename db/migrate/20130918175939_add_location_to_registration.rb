class AddLocationToRegistration < ActiveRecord::Migration
  class ParkingRegistration < ActiveRecord::Base
  end

  def self.up
    add_column :parking_registrations, :location, :string

    ParkingRegistration.find_each do |registration|
      registration.location = 'Winter Street'
      registration.save!
    end

    change_column :parking_registrations, :location, :string,
      null: false

  end

  def self.down
    remove_column :parking_registrations, :location
  end
end

class CreateLocations < ActiveRecord::Migration
  class Location < ActiveRecord::Base
    has_many :parking_registrations
  end

  class ParkingRegistration < ActiveRecord::Base
    belongs_to :normalized_location,
      class_name: 'Location',
      foreign_key: 'location_id'

  end

  def self.up
    create_table :locations do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_column :parking_registrations, :location_id, :integer

    ParkingRegistration.find_each do |reg|
      reg.normalized_location =
        Location.find_or_create_by_name!(reg.location)
      reg.save!
    end
  end

  def self.down
    ParkingRegistration.find_each do |reg|
      reg.location = reg.normalized_location.name
      reg.save!
    end

    drop_table :locations
    remove_column :parking_registrations, :location_id
  end
end

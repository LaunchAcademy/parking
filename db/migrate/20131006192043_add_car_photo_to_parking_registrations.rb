class AddCarPhotoToParkingRegistrations < ActiveRecord::Migration
  def change
    add_column :parking_registrations, :car_photo, :string
  end
end

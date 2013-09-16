class CreateParkingRegistrations < ActiveRecord::Migration
  def change
    create_table :parking_registrations do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.integer :spot_number, null: false
      t.date :parked_on, null: false

      t.timestamps
    end
  end
end

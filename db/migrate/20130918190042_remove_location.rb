class RemoveLocation < ActiveRecord::Migration
  def change
    remove_column :parking_registrations, :location, :string
  end
end

class ParkingRegistration < ActiveRecord::Base
  belongs_to :location

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :parked_on

  validates_format_of :email,
    with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i

  validates_numericality_of :spot_number,
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 60

  # validates_uniqueness_of :spot_number,
    # scope: :parked_on

  validate :already_occupied_spot

  validates_presence_of :location

  def park
    self.parked_on = Date.today
    save
  end

  protected
  def already_occupied_spot
    if self.spot_number.present? && self.parked_on.present?
      other_registration_count = 0
      if self.persisted?
        other_registration_count = self.class.where({
          parked_on: self.parked_on,
          spot_number: self.spot_number
        }).where(["id <> ?", self.id]).count
      else
        other_registration_count = self.class.where({
          parked_on: self.parked_on,
          spot_number: self.spot_number
        }).count
      end

      if other_registration_count > 0
        self.errors.add(:spot_number, 'is already taken')
      end
    end
  end
end

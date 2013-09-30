class ParkingConfirmation < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.parking_confirmation.receipt.subject
  #
  def receipt(parking_registration)
    @parking_registration = parking_registration

    mail to: parking_registration.email,
      subject: 'Parking Confirmation'
  end
end

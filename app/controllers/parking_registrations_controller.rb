class ParkingRegistrationsController < ApplicationController
  def new
    @last_registration = ParkingRegistration.find_by_id(session[:last_registration_id])
    @parking_registration = ParkingRegistration.new

    @parking_registration.email = @last_registration.try(:email)
    # above line is similar to what's below
    # if @last_registration.present?
    #   @parking_registration.email = @last_registration.email
    # end
  end

  def create
    @parking_registration = ParkingRegistration.new(reg_params)
    if @parking_registration.park
      session[:last_registration_id] = @parking_registration.id
      flash[:notice] = 'You registered successfully'
      redirect_to parking_registration_path(@parking_registration)
    else
      render :new
    end
  end

  protected
  def reg_params
    params.require(:parking_registration).permit(
      :first_name,
      :last_name,
      :email,
      :spot_number)
  end
end

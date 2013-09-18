class ParkingRegistrationsController < ApplicationController
  def new
    @last_registration = ParkingRegistration.find_by_id(
      session[:last_registration_id])
    @parking_registration = ParkingRegistration.new
  end

  def create
    @parking_registration = ParkingRegistration.new(reg_params)
    if @parking_registration.park
      session[:last_registration_id] = @parking_registration.id
      flash[:notice] = 'You registered successfully'
      redirect_to '/'
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
      :spot_number,
      :location_id)
  end
end

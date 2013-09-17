class ParkingRegistrationsController < ApplicationController
  def new
    @parking_registration = ParkingRegistration.new
  end

  def create
    @parking_registration = ParkingRegistration.new(params[:parking_registration])
    if @parking_registration.park
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
      :spot_number)
  end
end

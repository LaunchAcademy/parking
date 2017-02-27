class ParkingRegistrationsController < ApplicationController
  def new
    @parking_registration = ParkingRegistration.new
  end

  def create
    @parking_registration = ParkingRegistration.new(reg_params)
    if @parking_registration.park
      flash[:notice] = 'You registered successfully'
      redirect_to "/parking_registrations/#{@parking_registration.id}"
    else
      render :new
    end
  end

  def show
    @parking_registration = ParkingRegistration.find(params[:id])
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

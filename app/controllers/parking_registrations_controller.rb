class ParkingRegistrationsController < ApplicationController
  helper_method :yesterdays_registration

  def new
    @parking_registration = ParkingRegistration.new
  end

  def create
    @parking_registration = ParkingRegistration.new(reg_params)
    if @parking_registration.park
      # if session[:registration_ids].nil?
      #   session[:registration_ids] = []
      # end
      session[:registration_ids] ||= []
      session[:registration_ids] << @parking_registration.id
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

  def yesterdays_registration
    ParkingRegistration.for_yesterday(session[:registration_ids])
  end
end

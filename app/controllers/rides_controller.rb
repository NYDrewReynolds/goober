class RidesController < ApplicationController
  before_action :check_for_current_ride

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.rider_id = current_user.id
    if @ride.save
      flash[:notice] = "You have requested a ride!"
      redirect_to dashboard_path
    else
      flash[:error] = "Please be sure to fill out all fields"
      render :new
    end
  end

  private

  def ride_params
    params.require(:ride).permit(:pickup_location, :dropoff_location, :passenger_count)
  end
end

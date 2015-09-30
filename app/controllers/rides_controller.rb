class RidesController < ApplicationController
  before_action :check_for_current_ride

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.rider_id = current_user.id
    @ride.map_math
    if @ride.save
      flash[:notice] = "You have requested a ride!"
      redirect_to dashboard_path
    else
      flash[:error] = "Please be sure to fill out all fields"
      render :new
    end
  end

  def edit
    @ride = Ride.find(params[:id])
    @ride.update_status_and_time
    if @ride.driver_id.nil?
      @ride.update!(driver_id: current_user.id)
    end
    redirect_to dashboard_path
  end

  private

  def ride_params
    params.require(:ride).permit(:pickup_location, :dropoff_location, :passenger_count)
  end
end

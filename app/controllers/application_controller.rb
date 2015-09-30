class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_ride
    @current_ride ||= Ride.where(rider_id: current_user.id).where(status: [0,1,2]).first
  end

  def currently_driving
    @current_ride ||= Ride.where(driver_id: current_user.id).where(status: [1, 2]).first
  end

  def available_rides
    @available_rides ||= Ride.where(status: 0).where("passenger_count <= ?", current_user.car_capacity)
  end

  def completed_rides
    @completed_rides ||= Ride.where("rider_id = ? OR driver_id = ?", current_user.id, current_user.id)
  end

  def require_login
    unless current_user
      redirect_to root_path
    end
  end

  def check_for_current_ride
    if current_ride
      redirect_to dashboard_path
    end
  end

  helper_method :current_user
  helper_method :current_ride
  helper_method :available_rides
  helper_method :currently_driving
  helper_method :completed_rides
end

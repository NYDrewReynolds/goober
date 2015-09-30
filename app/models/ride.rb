class Ride < ActiveRecord::Base

  validates_presence_of :pickup_location, :dropoff_location, :passenger_count

  enum status: [:active, :accepted, :picked_up, :completed]

  def requested_time
    created_at
  end

  def update_status_and_time
    if status == "active"
      self.accepted! && set_accepted_time
    elsif status == "accepted"
      self.picked_up! && set_pickup_time
    elsif status == "picked_up"
      self.completed! && set_completed_time && calculate_cost
    end
  end

  def set_accepted_time
    self.update!(accepted_time: Time.now)
  end

  def set_pickup_time
    self.update!(pickup_time: Time.now)
  end

  def set_completed_time
    self.update!(dropoff_time: Time.now)
  end

  def ride_driver
    @ride_driver ||= User.find(self.driver_id)
  end

  def ride_rider
    @ride_rider ||= User.find(self.rider_id)
  end

  def calculate_cost
    length_of_ride = (self.dropoff_time - self.pickup_time)
    result = (length_of_ride / 180) * 2
    self.update!(cost: result.round(2))
  end

  def map_math
    directions = GoogleDirections.new(self.pickup_location, self.dropoff_location)
    calculate_distance(directions)
    calculate_eta(directions)
  end

  def calculate_distance(directions)
    distance = directions.drive_time_in_minutes
    self.update!(distance: distance)
  end

  def calculate_eta(directions)
    eta = directions.distance_in_miles
    self.update!(drive_time: eta)
  end
end

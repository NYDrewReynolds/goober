class Ride < ActiveRecord::Base

  enum status: [:active, :accepted, :picked_up, :completed]

  def requested_time
    created_at
  end

  def update_status_and_time
    if status == "active"
      self.accepted! && set_accepted_time
    elsif status == "accepted"
      self.picked_up! && set_pickup_time
    elsif status == "pickedup"
      self.completed! && set_completed_time
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

end

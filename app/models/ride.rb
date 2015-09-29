class Ride < ActiveRecord::Base

  enum status: [:active, :accepted, :pickedup, :completed]

  def requested_time
    created_at
  end

end

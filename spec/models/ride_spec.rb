require 'rails_helper'

RSpec.describe Ride, type: :model do
  context "when created" do

    let(:valid_attributes) { {pickup_location: "1510 Blake St. Denver, CO 80202",
                              dropoff_location: "2546 California St. Denver, CO 80205",
                              passenger_count: 2 } }

    it "is valid" do
      ride = Ride.create(valid_attributes)

      expect(ride).to be_valid
    end

    it "is invalid without a pickup location" do
      ride = Ride.create( dropoff_location: "2546 California St. Denver, CO 80205",
                          passenger_count: 2)

      expect(ride).not_to be_valid
    end

    it "is invalid without a dropoff location" do
      ride = Ride.create(pickup_location: "1510 Blake St. Denver, CO 80202",
                         passenger_count: 2)

      expect(ride).not_to be_valid
    end

    it "is invalid without a passenger count" do
      ride = Ride.create(pickup_location: "1510 Blake St. Denver, CO 80202",
                         dropoff_location: "2546 California St. Denver, CO 80205")

      expect(ride).not_to be_valid
    end

    it "is assigned a requested time" do
      ride = Ride.create(valid_attributes)

      expect(ride).to be_valid
      expect(ride.requested_time).to eq(ride.created_at)
    end

    it "is assigned an active status when created" do
      ride = Ride.create(valid_attributes)

      expect(ride.status).to eq("active")
    end

    it "is can change from active to accepted" do
      ride = Ride.create(valid_attributes)

      expect(ride.status).to eq("active")
      ride.update_status_and_time
      expect(ride.status).to eq("accepted")
    end

    it "is assigned accepted time when status changed" do
      ride = Ride.create(valid_attributes)

      expect(ride.status).to eq("active")
      ride.update_status_and_time
      expect(ride.status).to eq("accepted")
      expect(ride.accepted_time).not_to be_nil
    end

    it "is can change from accepted to picked up" do
      ride = Ride.create(valid_attributes)
      ride.update_status_and_time
      expect(ride.status).to eq("accepted")
      ride.update_status_and_time
      expect(ride.status).to eq("picked_up")
    end

    it "is assigned pickup time when status changed" do
      ride = Ride.create(valid_attributes)
      ride.update_status_and_time
      expect(ride.status).to eq("accepted")
      ride.update_status_and_time
      expect(ride.status).to eq("picked_up")
      expect(ride.pickup_time).not_to be_nil
    end

    it "is can change from picked up to completed" do
      ride = Ride.create(valid_attributes)
      ride.update_status_and_time
      ride.update_status_and_time
      expect(ride.status).to eq("picked_up")
      ride.update_status_and_time
      expect(ride.status).to eq("completed")
    end

    it "is assigned completed time when status changed" do
      ride = Ride.create(valid_attributes)
      ride.update_status_and_time
      ride.update_status_and_time
      expect(ride.status).to eq("picked_up")
      ride.update_status_and_time
      expect(ride.status).to eq("completed")
      expect(ride.dropoff_time).not_to be_nil
    end

    it "is assigned ride distance" do
      ride = Ride.create(valid_attributes)
      ride.map_math
      expect(ride.distance).not_to be_nil
    end

    it "is assigned drive time" do
      ride = Ride.create(valid_attributes)
      ride.map_math
      expect(ride.drive_time).not_to be_nil
    end

    it "is valid with rider & driver ID" do
      rider = User.create(name: "Johnny Appleseed",
                          email: "hello123@email.com",
                          phone_number: "15169872695",
                          password: "password")

      driver = User.create(name: "Johnny Appleseed",
                           email: "hello-driver@email.com",
                           phone_number: "15169872695",
                           password: "password",
                           role: 1)

      ride = Ride.create(pickup_location: "1510 Blake St. Denver, CO 80202",
                         dropoff_location: "2546 California St. Denver, CO 80205",
                         passenger_count: 2,
                         rider_id: rider.id,
                         driver_id: driver.id)

      expect(ride).to be_valid
      expect(ride.ride_driver.id).to eq(driver.id)
      expect(ride.ride_rider.id).to eq(rider.id)
    end

  end
end

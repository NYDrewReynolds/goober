class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :pickup_location
      t.string :dropoff_location
      t.integer :distance
      t.integer :drive_time
      t.integer :passenger_count
      t.integer :status, default: 0
      t.datetime :accepted_time
      t.datetime :pickup_time
      t.datetime :dropoff_time
      t.float :cost
      t.integer :rider_id
      t.integer :driver_id
      t.timestamps null: false
    end
  end
end

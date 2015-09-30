require "rails_helper"

RSpec.feature "User", :type => :feature do
  context "with valid login credentials" do
    let!(:user) { User.create(name: "Drew Reynolds",
                              email: "drew1234567111@turing.io",
                              phone_number: "15169872694",
                              password: "password",
                              role: 1,
                              car_make: "Honda",
                              car_model: "Civic",
                              car_capacity: 4) }

    rider = User.create(name: "Johnny Appleseed",
                        email: "hello123@email.com",
                        phone_number: "15169872695",
                        password: "password")

    Ride.create(pickup_location: "1510 Blake St. Denver, CO 80202",
                       dropoff_location: "2546 California St. Denver, CO 80205",
                       passenger_count: 2,
                       rider_id: rider.id)

    scenario "can request a ride" do
      visit root_path
      within(".navbar-form") do
        fill_in "Email", with: "drew1234567111@turing.io"
        fill_in "Password", with: "password"
        click_link_or_button "Login"
      end
      expect(page).to have_content("Hello, Drew Reynolds! - Driver")
      expect(page).to have_content("1510 Blake St. Denver, CO 80202")
      first('.btn').click
      expect(page).to have_content("Accepted")
      click_link_or_button "Pick Up Rider"
      expect(page).to have_content("Picked up")
      click_link_or_button "Complete Ride"
      expect(page).not_to have_content("Ride Status")
    end

  end

end

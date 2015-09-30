require "rails_helper"

RSpec.feature "User", :type => :feature do
  context "with valid login credentials" do
    let!(:user) { User.create(name: "Drew Reynolds",
                              email: "drew12345@turing.io",
                              phone_number: "15169872694",
                              password: "password") }

    scenario "can request a ride" do
      visit root_path
      within(".navbar-form") do
        fill_in "Email", with: "drew12345@turing.io"
        fill_in "Password", with: "password"
        click_link_or_button "Login"
      end
      expect(page).to have_content("Hello, Drew Reynolds! - Rider")
      click_link_or_button "Request a Ride"
      within(".form-group") do
        fill_in "pickup location", with: "1510 Blake St. Denver, CO 80202"
        fill_in "dropoff location", with: "2546 California St. Denver, CO 80205"
        fill_in "number of passengers", with: "2"
        click_link_or_button "Request a Ride"
      end
      expect(page).to have_content("Hello, Drew Reynolds! - Rider")
      expect(page).to have_content("Ride Status")
      expect(page).to have_content("1510 Blake St. Denver, CO 80202")
      expect(page).to have_content("2546 California St. Denver, CO 80205")
    end

  end

end

require "rails_helper"

RSpec.describe "User " do

  context "with valid log in credentials" do

    scenario "can sign up as a driver" do
      visit root_path
      click_link_or_button "Become a Driver"
      within(".form-group") do
        fill_in "name", with: "Steve Shafford"
        fill_in "email", with: "drew#{ (1..1000).to_a.sample }@fake.com"
        fill_in "phone number", with: "15169872695"
        fill_in "password", with: "password"
        fill_in "confirm password", with: "password"
        fill_in "car make", with: "Ford"
        fill_in "car model", with: "Taurus"
        fill_in "car capacity", with: "4"
        click_link_or_button "Create Account"
      end
      expect(page).to have_content("Hello, Steve Shafford! - Driver")
    end

  end

  context "with invalid log in credentials" do

    scenario "can not sign up as a driver" do
      visit root_path
      click_link_or_button "Become a Driver"
      within(".form-group") do
        fill_in "name", with: "Steve Shafford"
        fill_in "email", with: "drew#{ (1..1000).to_a.sample }@fake.com"
        fill_in "password", with: "password"
        fill_in "confirm password", with: "password"
        click_link_or_button "Create Account"
      end
      expect(page).to_not have_content("Hello, Steve Shafford! - Driver")
    end

  end

end

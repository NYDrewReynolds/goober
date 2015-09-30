require "rails_helper"

RSpec.feature "User", :type => :feature do
  let!(:user) { User.create(name: "Drew Reynolds",
                            email: "drew123@turing.io",
                            phone_number: "15169872695",
                            password: "password") }

  context "with invalid log in credentials" do

    scenario "cannot log in without email or password" do
      visit root_path
      within(".navbar-form") do
        click_link_or_button "Login"
      end
      expect(current_path).to eq(root_path)
    end

    scenario "cannot log in without password" do
      visit root_path
      within(".navbar-form") do
        fill_in "Email", with: "#{user.email}"
        click_link_or_button "Login"
      end
      expect(current_path).to eq(root_path)
    end

    scenario "cannot log in without emaiil" do
      visit root_path
      within(".navbar-form") do
        fill_in "Password", with: "password"
        click_link_or_button "Login"
      end
      expect(current_path).to eq(root_path)
    end

  end

  context "with valid login credentials" do
    let!(:user) { User.create(name: "Drew Reynolds",
                              email: "drew12345@turing.io",
                              phone_number: "15169872694",
                              password: "password") }

    scenario "can log in" do
      visit root_path
      within(".navbar-form") do
        fill_in "Email", with: "drew12345@turing.io"
        fill_in "Password", with: "password"
        click_link_or_button "Login"
      end
      expect(page).to have_content("Hello, Drew Reynolds! - Rider")
    end

    scenario "can log out" do
      visit root_path
      within(".navbar-form") do
        fill_in "Email", with: "drew12345@turing.io"
        fill_in "Password", with: "password"
        click_link_or_button "Login"
      end
      expect(page).to have_content("Hello, Drew Reynolds! - Rider")
      within(".nav") do
        click_link_or_button "Logout"
      end
      expect(page).not_to have_content("Hello, Drew Reynolds! - Rider")
      expect(current_path).to eq(root_path)
    end
  end

end

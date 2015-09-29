require "rails_helper"

RSpec.describe "User" do
  let!(:user) { User.create(name: "Drew Reynolds", email: "drew123@turing.io", phone_number: "15169872695", password: "password") }

  context "with invalid log in credentials", js: true do

    scenario "cannot log in without email or password" do
      visit root_path
      within(".navbar-form") do
        click_link_or_button "Login"
      end
      expect(current_path).to eq(root_path)
    end

    scenario "cannot log in without password" do
      visit root_path
      click_link_or_button "Login"
      within(".navbar-form") do
        fill_in "Email", with: "#{user.email}"
        click_link_or_button "Login"
      end
      expect(current_path).to eq(root_path)
    end

    scenario "cannot log in without emaiil" do
      visit root_path
      click_link_or_button "Login"
      within(".navbar-form") do
        fill_in "Password", with: "password"
        click_link_or_button "Login"
      end
      expect(current_path).to eq(root_path)
    end

  end

  # context "with valid login credentials", js: true do
  #   let!(:user) { User.create(name: "Drew Reynolds", email: "drew123@turing.io", phone_number: "15169872695", password: "password") }

    # scenario "can log in" do
    #   visit root_path
    #   click_link_or_button "Login"
    #   within(".navbar-form") do
    #     fill_in "Email", with: "drew123@turing.io"
    #     fill_in "Password", with: "password"
    #     click_link_or_button "Login"
    #   end
    #   expect(page).to have_content("Hello, Drew Reynolds! - Rider")
    # end

    # scenario "can log out" do
    #   visit new_user_path
    #   expect(page).to have_content("Create Your Account")
    #   within(".form-group") do
    #     fill_in "first name", with: "Drewby"
    #     fill_in "email", with: "drew#{ (1..1000).to_a.sample }@fake.com"
    #     fill_in "password", with: "password"
    #     fill_in "confirm password", with: "password"
    #     click_link_or_button "Create Account"
    #   end
    #   expect(page).to have_content("Welcome Drewby!")
    #   expect(page).to have_content("Logout")
    #   click_link_or_button "Logout"
    #   expect(page).to have_content("Welcome to the Reading List!")
    # end
  # end

end

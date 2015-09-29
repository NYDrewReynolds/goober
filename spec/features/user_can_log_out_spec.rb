# require "rails_helper"
#
# RSpec.describe "User " do
#   let!(:user) { User.create(email: "drew@email.com", password: "password", first_name: "Drew") }
#
#   context "with invalid log in credentials", js: true do
#
#     scenario "cannot log in without email or password" do
#       visit root_path
#       click_link_or_button "Login"
#       within(".form-group") do
#         click_link_or_button "login"
#       end
#       expect(page).to have_content("Invalid Login")
#     end
#
#     scenario "cannot log in without password" do
#       visit root_path
#       click_link_or_button "Login"
#       within(".form-group") do
#         fill_in "email", with: "#{user.email}"
#         click_link_or_button "login"
#       end
#       expect(page).to have_content("Invalid Login")
#     end
#
#     scenario "cannot log in without emaiil" do
#       visit root_path
#       click_link_or_button "Login"
#       within(".form-group") do
#         fill_in "password", with: "password"
#         click_link_or_button "login"
#       end
#       expect(page).to have_content("Invalid Login")
#     end
#
#   end
#
#   context "with valid login credentials", js: true do
#
#     scenario "can sign up" do
#       visit new_user_path
#       expect(page).to have_content("Create Your Account")
#       within(".form-group") do
#         fill_in "first name", with: "Drewby"
#         fill_in "email", with: "drew#{ (1..1000).to_a.sample }@fake.com"
#         fill_in "password", with: "password"
#         fill_in "confirm password", with: "password"
#         click_link_or_button "Create Account"
#       end
#       expect(page).to have_content("Welcome Drewby!")
#       expect(page).to have_content("Logout")
#     end
#
#     scenario "can log out" do
#       visit new_user_path
#       expect(page).to have_content("Create Your Account")
#       within(".form-group") do
#         fill_in "first name", with: "Drewby"
#         fill_in "email", with: "drew#{ (1..1000).to_a.sample }@fake.com"
#         fill_in "password", with: "password"
#         fill_in "confirm password", with: "password"
#         click_link_or_button "Create Account"
#       end
#       expect(page).to have_content("Welcome Drewby!")
#       expect(page).to have_content("Logout")
#       click_link_or_button "Logout"
#       expect(page).to have_content("Welcome to the Reading List!")
#     end
#   end
#
# end

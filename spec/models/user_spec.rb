require 'rails_helper'

RSpec.describe User, type: :model do
  context "when created" do

    let(:valid_attributes) { {name: "Johnny Appleseed",
                              email: "hello123@email.com",
                              phone_number: "15169872695",
                              password: "password"} }

    let(:valid_driver) { {name: "Johnny Appleseed",
                              email: "hello123@email.com",
                              phone_number: "15169872695",
                              password: "password",
                              car_make: "Honda",
                              car_model: "Civic",
                              car_capacity: 2,
                              role: 1} }

    it "is valid" do
      user = User.create(valid_attributes)

      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = User.create(email: "hello123@email.com",
                         phone_number: "15169872695",
                         password: "password")

      expect(user).not_to be_valid
    end

    it "is invalid without an email" do
      user = User.create(name: "Johnny Appleseed",
                         phone_number: "15169872695",
                         password: "password")

      expect(user).not_to be_valid
    end

    it "is invalid without a phone number" do
      user = User.create(name: "Johnny Appleseed",
                         email: "hello123@email.com",
                         password: "password")

      expect(user).not_to be_valid
    end

    it "is assigned a Rider role by default" do
      user = User.create(valid_attributes)

      expect(user).to be_valid
      expect(user.role).to eq("rider")
    end

    it "is invalid unless email is unique" do
      user_one = User.create(valid_attributes)
      user_two = User.create(name: "Drew", email: "hello123@email.com", phone_number: "15169872695", password: "password")

      expect(user_one).to be_valid
      expect(user_two).not_to be_valid
    end

    it "is able to sign up as a driver" do
      user = User.create(valid_driver)

      expect(user).to be_valid
      expect(user.role).to eq("driver")
    end


  end
end

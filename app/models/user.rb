class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :name, :phone_number
  validates_uniqueness_of :email, :password_digest

  enum role: [:rider, :driver]

end

class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email, :password

  validates_uniqueness_of :email

  has_secure_password

  enum role: %w(user merchant_employee admin visitor)
end

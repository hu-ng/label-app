class User < ApplicationRecord
  has_secure_password

  has_many :addresses
  has_many :parcels
  has_many :shipments
end

class Shipment < ApplicationRecord
  belongs_to :user

  validate :different_addresss

  def different_addresss
    if to_address_id == from_address_id
      errors.add(:to_address_id, "Cannot send parcel to the same location")
    end
  end
end

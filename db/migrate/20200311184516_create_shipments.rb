class CreateShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|
      t.string :unique_id
      t.references :user, foreign_key: true
      t.references :to_address, foreign_key: { to_table: 'Addresses' }
      t.references :from_address, foreign_key: { to_table: 'Addresses' }
      t.references :parcel, foreign_key: true

      t.timestamps
    end
  end
end

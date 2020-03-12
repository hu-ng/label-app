class AddTitleToParcels < ActiveRecord::Migration[5.2]
  def change
    add_column :parcels, :title, :string
  end
end

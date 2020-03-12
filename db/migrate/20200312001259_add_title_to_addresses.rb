class AddTitleToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :title, :string
  end
end

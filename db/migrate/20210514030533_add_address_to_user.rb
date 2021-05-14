class AddAddressToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :street_number, :string
    add_column :users, :unit, :string
    add_column :users, :street, :string
    add_column :users, :suburb, :string
    add_column :users, :postcode, :string
    add_column :users, :state, :string
  end
end

class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country, :default => 'US'
      t.string :phone
      t.references :s_addable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

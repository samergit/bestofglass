class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :tracking
      t.string :carrier
      t.references :order, index: true, foreign_key: true
      t.integer :shipper_id
      t.integer :buyer_id
      t.string :url

      t.timestamps null: false
    end
  end
end

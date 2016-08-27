class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :active, :default => true
      t.boolean :successful, :default => false
      t.string :slug
      t.string :shipping_area
      t.float :buy_it_now_price
      t.float :price_increment, :default => 1
      t.float :shipping_price, :default => 0
      t.float :reserve, :default => 0
      t.integer :length, :default => 1
      t.float :starting_price, :default => 0
      t.float :current_price, :default => 0 # will default to starting price if starting price > 0
      t.float :final_price, :default => 0
      t.integer :highest_bidder
      t.integer :winner_id
      t.boolean :display_price, :default => 'true'
      t.datetime :relist_time
      t.boolean :relisted, :default => 'false'

      t.timestamps null: false
     end
    add_index :auctions, :active
    add_index :auctions, :slug, unique: true
    add_index :auctions, :winner_id
  end
end

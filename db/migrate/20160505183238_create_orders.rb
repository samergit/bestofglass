class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :sellable, polymorphic: true, index: true
      t.string :number
      t.float :amount
      t.float :shipping_amount
      t.float :sales_tax
      t.float :seller_cut
      t.float :final_amount
      t.float :our_cut
      t.integer :buyer_id
      t.integer :seller_id
      t.boolean :deposited_order, :default => true
      t.boolean :paid, :default => false
      t.boolean :shipped, :default => false
      t.boolean :delivered, :default => false
      t.boolean :seller_preliminary_pay, :default => false #final check before  seller_paid
      t.boolean :seller_paid, :default => false  #set to true once all checks cleared
      t.boolean :deposit_paid, :default => false #set to true if deposit 
      t.boolean :voided, :default => false 
      t.boolean :abandoned, :default => true #for none finalized orders


      t.timestamps null: false
    end
  end
end

class CreateTotals < ActiveRecord::Migration
  def change
    create_table :totals do |t|
      t.string :year
      t.float :pending_revenue
      t.float :total_revenue
      t.float :cut
      t.float :sales_tax
      t.float :payout
      t.integer :transactions

      t.timestamps null: false
    end
  end
end

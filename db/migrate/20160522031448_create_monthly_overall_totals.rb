class CreateMonthlyOverallTotals < ActiveRecord::Migration
  def change
    create_table :monthly_overall_totals do |t|
      t.references :total, index: true, foreign_key: true
      t.float :amount
      t.string :month
      t.float :sales_tax
      t.integer :transactions

      t.timestamps null: false
    end
  end
end

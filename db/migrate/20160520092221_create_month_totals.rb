class CreateMonthTotals < ActiveRecord::Migration
  def change
    create_table :month_totals do |t|
      t.string :month
      t.float :total
      t.references :year_totals, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateYearTotals < ActiveRecord::Migration
  def change
    create_table :year_totals do |t|
      t.string :year
      t.float :total
      t.integer :transactions
      t.references :user, index: true, foreign_key: true


      t.timestamps null: false
    end
  end
end

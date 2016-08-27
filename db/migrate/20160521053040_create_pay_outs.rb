class CreatePayOuts < ActiveRecord::Migration
  def change
    create_table :pay_outs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true 
      t.float :amount

      t.timestamps null: false
    end
  end
end

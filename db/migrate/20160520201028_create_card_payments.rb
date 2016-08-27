class CreateCardPayments < ActiveRecord::Migration
  def change
    create_table :card_payments do |t|
      t.references :order, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :ip_address
      t.string :last4

      t.timestamps null: false
    end
  end
end

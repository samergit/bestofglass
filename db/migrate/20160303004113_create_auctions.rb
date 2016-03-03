class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.references :bid, index: true, foreign_key: true
      t.string :title
      t.references :artist, index: true, foreign_key: true
      t.text :description
      t.datetime :end_time
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

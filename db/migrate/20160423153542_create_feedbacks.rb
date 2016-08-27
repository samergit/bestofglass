class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.references :feedbackable,  polymorphic: true, index: true
      t.integer :score
      t.text :content
      t.boolean :seller_received, :default => false
      t.boolean :buyer_received, :default => false

      t.timestamps null: false
    end
    add_index :feedbacks, :seller_id
    add_index :feedbacks, :buyer_id
  end
end

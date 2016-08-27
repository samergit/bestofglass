class CreateBaggableItems < ActiveRecord::Migration
  def change
    create_table :baggable_items do |t|
      t.references :bag, index: true, foreign_key: true
      t.references :baggable, polymorphic: true, index: true
      t.integer :type
    
      

      t.timestamps null: false
    end
  end
end

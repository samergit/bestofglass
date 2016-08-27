class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :category
      t.references :itemable,  polymorphic: true, index: true
      t.references :user, index: true, foreign_key: true
      t.string :height
      t.string :joint
      t.string :perc
      t.string :pendant_length
      t.string :dry_pipe_style
      t.string :width
      t.string :hole_size
      t.string :accessory_type
      t.string :artist
      t.text :description

      t.timestamps null: false
    end
    add_index :items, :category
  end
end

class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachable,  polymorphic: true, index: true
      t.string :attachment

      t.timestamps null: false
    end
  end
end

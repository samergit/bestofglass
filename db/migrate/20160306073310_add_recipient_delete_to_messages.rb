class AddRecipientDeleteToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :recipient_delete, :boolean, :default => false
  end
end

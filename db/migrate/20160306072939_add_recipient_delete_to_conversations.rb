class AddRecipientDeleteToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :recipient_delete, :boolean, :default => false
  end
end

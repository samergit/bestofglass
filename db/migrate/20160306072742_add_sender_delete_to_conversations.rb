class AddSenderDeleteToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :sender_delete, :boolean, :default => false
  end
end

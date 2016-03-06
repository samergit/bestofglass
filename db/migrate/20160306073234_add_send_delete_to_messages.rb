class AddSendDeleteToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :send_delete, :boolean, :default => false
  end
end

class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  def read?(current_user)
    if self.user_id != current_user.id && self.read == false
      self.read = true
      self.save
    end
  end

   def is_deleted?(user)
      @user = user
      if self.conversation.sender_id == @user.id && self.send_delete == true 
        return true
      elsif self.conversation.recipient_id == @user.id && self.recipient_delete == true 
        return true   
      else
        false
      end
   end    

end

  #delete in console or admin panel
  def delete_all
    self.destroy
  end
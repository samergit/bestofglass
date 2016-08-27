class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"
  has_many :messages, :foreign_key => :conversation_id, class_name: "Message", dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id


  def recipient_message(user)
    @user = user
    if self.sender.id == @user.id
      @recipient = User.find(self.recipient.id)
      return @recipient.username
    elsif self.recipient.id == @user.id
      @recipient = User.find(self.sender.id)
      return @recipient.username
    end  
  end    


  def recipient_message_update(user)
    @user = user
    if self.sender.id == @user.id
      @recipient = User.find(self.recipient.id)
      return @recipient
    elsif self.recipient.id == @user.id
      @recipient = User.find(self.sender.id)
      return @recipient
    end  
  end  

  #one sided soft deletes convo and messages if first conversation parcipitant to delete
  #hard deletes if both conversation participants have deleted convo
  def delete_convo(user)
    @user = user
    if self.sender.id == @user.id
      self.sender_delete = true
      self.save
      if self.sender_delete == true && self.recipient_delete == true  
        self.destroy
      else
        self.messages.each do |message| 
          message.send_delete = true
          message.save
        end
      end  #check this if errors after edit, added elsif instead of separate if
    elsif self.recipient.id == @user.id
      self.recipient_delete = true
      self.save
      if self.recipient_delete == true && self.sender_delete == true 
        self.destroy
      else 
        self.messages.each do |message| 
          message.recipient_delete = true
          message.save
        end    
      end   
    end
  end

  #check to see if conversation is deleted by either recipient or sender
  def deleted?(user)
    @user = user
    if self.sender.id == @user.id && self.sender_delete == true
      return true
    elsif self.recipient.id == @user.id && self.recipient_delete == true
      return true   
    else
      return false
    end  
  end

  #undoes the one-sided soft delete of convo if new message sent
  def undelete(user, user2)
    @user = user
    @user2 = user2
    if (self.sender.id == @user.id || self.sender.id == @user2.id) && self.sender_delete == true
      self.sender_delete = false
      self.save
    elsif (self.recipient.id == @user.id || self.recipient.id == @user2.id) && self.recipient_delete == true
      self.recipient_delete = false
      self.save   
    end  
  end

  def unviewed
    self.update_attribute(:read, false)
  end

  def has_been_viewed
    self.update_attribute(:read, true)
  end

end
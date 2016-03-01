class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"
  has_many :messages, :foreign_key => :conversation_id, class_name: "Message"

  validates_uniqueness_of :sender_id, :scope => :recipient_id


  def recipientMessage(user)
    @user = user
    if self.sender.id == @user.id
      @recipient = User.find(self.recipient.id)
      return @recipient.username
    elsif self.recipient.id == @user.id
      @recipient = User.find(self.sender.id)
      return @recipient.username
    end  
  end    

end
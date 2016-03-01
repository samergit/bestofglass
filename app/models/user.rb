class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :messages
  validates :date_of_birth, :presence => true
  validates_inclusion_of :date_of_birth, :in=>Date.new(1916)..Time.now.years_ago(18).to_date, :message=>'You must be 18 years or older'
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :trackable, :validatable


  def conversations
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", self, self)
    return @conversations
  end


  def recipientCheck(conversation)
    @conversation = Conversation.find(conversation)
    if @conversation.sender_id == self.id
      return User.find(@conversation.recipient.id)
    elsif @conversation.recipient_id == self.id
      return User.find(@conversation.sender_id)
    end  
  end  

  def convoCheck(recipient)
    @recipient = recipient 
    if Conversation.where(sender_id: self.id, recipient_id: @recipient.id).present?
      @conversation =  Conversation.where(sender_id: self.id, recipient_id: @recipient.id).first
      return @conversation
    elsif  
      Conversation.where(sender_id: @recipient.id, recipient_id: self.id).present?
        @conversation = Conversation.where(sender_id: @recipient.id, recipient_id: self.id).first
        return @conversation
    else 
      return false    
    end



  end

end


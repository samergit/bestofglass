class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    @recipient = @conversation.recipient_message(current_user)
    if @messages.present?
      @messages.last.read?(current_user)
    end  
  end

  def create
    @user = @conversation.sender
    @user2 = @conversation.recipient
    @message = current_user.messages.new(:conversation_id => @conversation.id, body: params[:message][:body])
    if @message.save
      @conversation.undelete(@user, @user2)
      @message.conversation.touch(:updated_at) 
      redirect_to conversation_messages_path
    end  
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end

end

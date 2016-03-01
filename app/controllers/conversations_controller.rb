class ConversationsController < ApplicationController
  before_filter:authenticate_user!
  def index
    @conversations =  current_user.conversations
  end

  def create
    @recipient = User.find_by_username(params[:username])
    @conversation = current_user.convoCheck(@recipient) 
    if  @conversation != false
      redirect_to conversation_messages_path(@conversation)
    else
      @conversation = Conversation.create!(sender_id: current_user.id, recipient_id: @recipient.id)
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end

end

class ConversationsController < ApplicationController
  before_filter:authenticate_user!
  def index
    @conversations =  current_user.conversations
    current_user.touch :last_viewed_messages_page
  end

  def create
    @recipient = User.find_by_username(params[:username])
    @conversation = current_user.convo_check(@recipient) 
    if  @conversation.present?
      redirect_to conversation_messages_path(@conversation)
    else
      @conversation = Conversation.create!(sender_id: current_user.id, recipient_id: @recipient.id)
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.delete_convo(current_user)
    redirect_to conversations_path
  end  

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end



end

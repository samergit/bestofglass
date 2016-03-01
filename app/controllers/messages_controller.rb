class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    @recipient = current_user.recipientCheck(@conversation.id)
    if @messages.present?
      @messages.last.read?(current_user)
    end  
  end

  def new
    @message = current_user.messages.new
  end

  def create
    @body = params[:message][:body]
    @message = current_user.messages.new(:conversation_id => @conversation.id, :body=> @body)
    if @message.save
      redirect_to root_path
    end  
  end



  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end

end

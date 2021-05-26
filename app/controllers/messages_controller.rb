class MessagesController < ApplicationController
  before_action :set_conversation

  #Reply to conversations
  def create()
    # raise
    if message_params[:reply].empty?
      flash[:alert] = "You cannot send a blank message"
      redirect_to conversation_path(@conversation)
    else
      receipt = current_user.reply_to_conversation(@conversation, message_params)
      redirect_to conversation_path(receipt.conversation)
    end
  end

  private

  def message_params
    params.permit(:reply)
  end

  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
  end
end

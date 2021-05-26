class MessagesController < ApplicationController
  before_action :set_conversation

  #Reply to conversations
  def create()
    receipt = current_user.reply_to_conversation(@conversation, message_params)
    redirect_to conversation_path(receipt.conversation)
  end

  private

  def message_params
    params.require(:reply)
  end

  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
  end
end

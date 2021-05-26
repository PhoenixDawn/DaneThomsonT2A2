class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @users = User.where.not(id: current_user.id)
  end

  def new_direct_message
    @user = User.find(params[:id])
  end

  def create_direct_message
    recipient = User.find(params[:id])
    receipt = current_user.send_message(recipient, get_body, get_subject)
    redirect_to conversation_path(receipt.conversation)
  end

  def create
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, get_body, get_subject)
    redirect_to conversation_path(receipt.conversation)
  end

  def destroy
    current_user.mailbox.conversations.find(params[:id]).destroy
    redirect_to conversations_path
  end

  private

  def get_body
    params.require(:body)
  end

  def get_subject
    params.require(:subject)
  end
end

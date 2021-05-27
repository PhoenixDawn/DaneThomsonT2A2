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
    if get_body[:body].empty? || get_subject[:subject].empty?
      flash[:alert] = "You cannot send a blank message"
      redirect_to direct_message_path(recipient.id)
    else
      receipt = current_user.send_message(recipient, get_body[:body], get_subject[:subject])
      redirect_to conversation_path(receipt.conversation)
    end
  end

  def destroy
    current_user.mailbox.conversations.find(params[:id]).destroy
    redirect_to conversations_path
  end

  private

  def get_body
    params.permit(:body)
  end

  def get_subject
    params.permit(:subject)
  end
end

class MessagesController < ApplicationController
  before_action :require_user_logged_in, only: [:index]
  
  def index
    set_user
    all_messages
    @message = Message.new
    @messages_users = current_user.messages.build(params[:id]) #現在のユーザーがメッセージをやりとりしているユーザーすべて
  end

  def create
    set_user
    @message = current_user.messages.build(message_params)
    @message.receive_user_id = @user.id
    
    if @message.save
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'メッセージを送信できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def show
    set_user
    all_messages
    @message = Message.new
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def all_messages
    @user = User.find(params[:user_id])
    send_messages = current_user.messages.where(receive_user_id: @user.id)
    receive_messages = @user.messages.where(receive_user_id: current_user.id)
    @messages = Message.where(id: send_messages + receive_messages)
    @or_messages = Message.where(id: send_messages || receive_messages)
  end

  def message_params
    params.require(:message).permit(:content, :receive_user_id, :user_id)
  end
end

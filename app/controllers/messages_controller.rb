class MessagesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    send_ids = current_user.messages.where(receive_user_id: @user.id).pluck(:id) #
    receive_ids = @user.messages.where(receive_user_id: current_user.id).pluck(:id)
    @messages = Message.where(id: send_ids + receive_ids)
    @message = Message.new
  end

  def create
    @user = User.find(params[:user_id])
    @message = current_user.messages.build(message_params)
    @message.receive_user_id = @user.id
    
    if @message.save
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'メッセージを送信できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  private

  def message_params
    params.require(:message).permit(:content)
  end
end

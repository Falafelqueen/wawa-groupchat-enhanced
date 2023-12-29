class MessagesController < ApplicationController
  def create
    @message = Message.new(text: message_params[:text], user: current_user, chatroom_id: params[:chatroom_id])
    respond_to do |format|
      if @message.save
        format.html { redirect_to chatroom_path(params[:chatroom_id]) }
        format.turbo_stream if @message.user == current_user
      else
        format.html { redirect_to chatroom_path(params[:chatroom_id]), alert: "Message could not be saved" }
      end
    end
  end

  def message_params
    params.require(:message).permit(:text)
  end
end

class UserChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:create, :destroy]

  def create
    user_chatroom = UserChatroom.new(user: current_user, chatroom: @chatroom)
    if user_chatroom.save!
      redirect_to chatroom_path(@chatroom)
    end
  end

  def destroy
    @user_chatroom = UserChatroom.find_by(chatroom: @chatroom, user: current_user)
    @user_chatroom.destroy
    respond_to do |format|
      format.html { redirect_to chatrooms_path }
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
end

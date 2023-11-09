class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]

  def index
    # Display chatrooms ordered by most recent messages first
    @chatrooms = Chatroom.ordered_by_latest_message
  end

  def show
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new
    @user =  current_user
  end

  def create
    @chatroom = Chatroom.new(name: params[:name])
    @chatroom.save
      #respond_to do |format|
      #  format.html { redirect_to chatroom_path(@chatroom) }
      #end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end
end

class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]
  before_action :get_current_user

  def index
    # Display chatrooms ordered by most recent messages first
    @chatrooms = Chatroom.ordered_by_latest_message
  end

  def show
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new

    @chatrooms = @user.chatrooms.ordered_by_latest_message
  end

  def create
    @chatroom = Chatroom.new(name: params[:name])
    @chatroom.save
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def get_current_user
    @user = current_user
  end
end

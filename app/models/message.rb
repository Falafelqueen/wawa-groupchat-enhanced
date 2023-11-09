class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  after_create_commit :update_chatroom
  after_create_commit :update_user_count

  private

  def update_chatroom
    # Update user count
    #broadcast_replace_to "chatroom", target: "user-count", partial: "chatrooms/user_count", locals: {count: chatroom.user_count}
    # Append message to chatroom
    broadcast_append_to "chatroom", target: "messages", partial: "messages/message", locals: { message: self }
    # Update chatroom list
    broadcast_replace_to "chatrooms", partial: "chatrooms/chatroom", target: "chatroom_#{chatroom.id}", locals: {chatroom: chatroom}
  end

  def update_user_count
    broadcast_replace_to "chatroom", target: "user-count", partial: "chatrooms/user_count", locals: {count: chatroom.user_count}
  end
end

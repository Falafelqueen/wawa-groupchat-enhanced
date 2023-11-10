class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  after_create_commit :update_chatroom
  after_create_commit :update_user_count
  after_create_commit :update_user_preview
  after_create_commit :join_chatroom

  private

  def join_chatroom
    # Add user to chatroom if not already a member
    unless chatroom.users.include?(user)
      chatroom.users << user
    end
  end

  def update_chatroom
    # Append message to chatroom
    broadcast_append_to "chatroom", target: "messages_#{chatroom.id}", partial: "messages/message", locals: { message: self }
    # Update chatroom list on index
    broadcast_replace_to "chatrooms", partial: "chatrooms/chatroom", target: "chatroom_#{chatroom.id}", locals: {chatroom: chatroom}
    # Update chatroom list on show
    broadcast_replace_to "chatroom", partial: "chatrooms/chatroom", target: "chatroom_#{chatroom.id}", locals: {chatroom: chatroom, hide_count: true}
  end

  def update_user_preview
    # Display the chatrooms in the preview list
    broadcast_replace_to "chatroom", partial: "chatrooms/chatroom_preview", target: "chatroom_preview", locals: {chatrooms: Chatroom.ordered_by_latest_message, hide_count: true }
  end

  def update_user_count
    broadcast_replace_to "chatroom", target: "user-count", partial: "chatrooms/user_count", locals: {count: chatroom.user_count}
    broadcast_replace_to "chatrooms", target: "user-count", partial: "chatrooms/user_count", locals: {count: chatroom.user_count}
  end
end

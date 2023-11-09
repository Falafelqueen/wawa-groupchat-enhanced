class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  after_create_commit :update_chatroom

  private

  def update_chatroom
    # Append message to chatroom
    broadcast_append_to "chatroom", target: "messages", partial: "messages/message", locals: { message: self }
    # broadcast_append_to "chatroom",target: "messages", partial: "messages/message", locals: { message: self, sender: false }
    broadcast_replace_to "chatrooms", partial: "chatrooms/chatroom", target: "chatroom_#{self.chatroom.id}", locals: {chatroom: self.chatroom}
  end
end

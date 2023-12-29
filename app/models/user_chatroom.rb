class UserChatroom < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :user_id, uniqueness: { scope: :chatroom_id }

  after_commit :update_user_count

  private

  def update_user_count
    broadcast_replace_to "chatroom", target: "user-count-#{chatroom.id}", partial: "chatrooms/user_count", locals: {chatroom: chatroom}
    broadcast_replace_to "chatrooms", target: "user-count-#{chatroom.id}", partial: "chatrooms/user_count", locals: {chatroom: chatroom}
  end
end

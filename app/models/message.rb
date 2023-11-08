class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  after_create_commit -> { broadcast_append_to "chatroom", partial: "messages/message", locals: { quote: self }, target: "messages" }
end
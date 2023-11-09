class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  validates :name, presence: true

  after_create_commit -> { broadcast_prepend_to "chatrooms", partial: "chatrooms/chatroom", target: "chatrooms", locals: {chatroom: self} }
end

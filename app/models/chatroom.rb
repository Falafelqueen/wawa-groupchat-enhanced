class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  validates :name, presence: true

  after_create_commit -> { broadcast_prepend_to "chatrooms", partial: "chatrooms/chatroom", target: "chatrooms", locals: {chatroom: self} }

  scope :ordered_by_latest_message, -> { joins(:messages).select('chatrooms.*, MAX(messages.created_at) AS latest_message_time')
      .group('chatrooms.id')
      .order('latest_message_time DESC') }

  def latest_message
    messages.order(created_at: :desc).first
  end

  def user_count
    users.uniq.count
  end
end

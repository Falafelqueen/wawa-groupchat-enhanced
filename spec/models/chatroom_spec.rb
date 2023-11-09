require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  describe "associations" do
    it "has many messages" do
      chatroom = Chatroom.new
      expect(chatroom).to respond_to(:messages)
      expect(chatroom.messages).to be_a(ActiveRecord::Associations::CollectionProxy)
    end

   it "has many users through messages" do
      chatroom = Chatroom.new
      expect(chatroom).to respond_to(:users)
      expect(chatroom.users).to be_a(ActiveRecord::Associations::CollectionProxy)
    end
  end

  describe "validations" do
    it "validates presence of name" do
      chatroom = Chatroom.new(name: "Sample Chatroom")

      expect(chatroom).to be_valid
    end

    it "is invalid without a name" do
      chatroom = Chatroom.new(name: nil)
      chatroom.valid?

      expect(chatroom.errors[:name]).to include("can't be blank")
    end
  end

  describe "after_create_commit callback" do
    it "broadcasts the chatroom creation via Turbo Streams" do
        chatroom = build(:chatroom)
        # Use Turbo Streams broadcasting to capture the streams
        expect {
          chatroom.save
        }.to broadcast_to("chatrooms") do |payload|
          expect(payload).to have_stream_from("chatroom_#{chatroom.id}").with_action(:append)
        end
      end
  end
end

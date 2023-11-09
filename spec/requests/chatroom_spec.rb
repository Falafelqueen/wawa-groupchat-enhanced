require 'rails_helper'

RSpec.describe "Chatrooms", type: :request do

  describe "GET :index" do
    before do
      user = create(:user)
      post '/users/sign_in', params: { user: { email: user.email, password: user.password } }
    end

    it "returns http success" do
      get chatrooms_path
      expect(response).to have_http_status(:success)
    end

    it "lists all chatrooms in descending order" do
      chatroom1 = create(:chatroom, created_at: 1.hour.ago)
      chatroom2 = create(:chatroom, name: 'Different chatroom')

      get chatrooms_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include(chatroom2.name)
      expect(response.body).to include(chatroom1.name)
      expect(response.body.index(chatroom2.name)).to be < response.body.index(chatroom1.name)
    end
  end
end

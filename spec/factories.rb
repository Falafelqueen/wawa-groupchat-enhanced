FactoryBot.define do
  factory(:chatroom) do
    name { "Great chatroom"}
  end

  factory(:user) do
    display_name { "Linda" }
    email { "linda2@linda.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end

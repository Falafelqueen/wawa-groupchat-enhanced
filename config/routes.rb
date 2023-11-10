Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "chatrooms#index"

   resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: :create
    resources :user_chatrooms, only: [:create, :destroy]
   end
end

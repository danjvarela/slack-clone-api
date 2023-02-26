Rails.application.routes.draw do
  resources :messages
  resources :channels
  post "/channels/:id/add_members", to: "channels#add_members", as: "add_channel_members"
  mount_devise_token_auth_for "User", at: "auth"
end

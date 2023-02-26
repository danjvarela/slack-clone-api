Rails.application.routes.draw do
  resources :messages
  resources :channels
  post "/channels/:id/add_member", to: "channels#add_member", as: "add_channel_member"
  mount_devise_token_auth_for "User", at: "auth"
end

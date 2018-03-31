Rails.application.routes.draw do
  resources :games
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout"}
end

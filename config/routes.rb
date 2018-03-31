Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout"}
  namespace :admin do
    resources :games
  end
end

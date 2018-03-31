Rails.application.routes.draw do
  root 'games#index'

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout"}

  resources :games, only: %i[index show] do
  	resources :entries, only: [:new, :create, :destroy]
  end

  namespace :admin do
    resources :games
  end
end

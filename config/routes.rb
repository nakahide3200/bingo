Rails.application.routes.draw do
  root 'games#index'

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout"}

  resources :games, only: %i[index show] do
  	resources :entries, only: [:new, :create, :destroy]
  end

  namespace :admin do
    resources :games do
      member do
        post :create_number, path: :numbers
      end 
    end
  end
end

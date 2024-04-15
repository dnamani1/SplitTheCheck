Rails.application.routes.draw do
  resources :votes
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }

  resources :votes, only: [:index, :show,  :create, :destroy]

  resources :restaurants, except: [:destroy] do
    member do
      patch :vote
    end
  end
  
  root to: 'restaurants#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

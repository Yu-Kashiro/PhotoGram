require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

root to: 'posts#index'

resources :posts do
  resource :like, only: [:show, :create, :destroy]
  resources :comments, only: [:index, :new, :create, :destroy]
end

resource :profile, only: [:show, :edit, :update] do
  scope module: :profile do
    resources :followers, only: [:index]
    resources :followings, only: [:index]
  end
end

resources :accounts, only: [:show] do
  resource :follows, only: [:show, :create]
  resource :unfollows, only: [:create]
  scope module: :accounts do
    resources :followers, only: [:index]
    resources :followings, only: [:index]
  end
end

end

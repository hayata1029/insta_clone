Rails.application.routes.draw do
  root to: 'staticpages#home'
  resources  :mypages,       only: [:show, :index,]
  resources :mypages do
    member do
      get :following, :followers
    end
  end
  devise_for :users, controllers: { registraions:       'users/registraions',
                                    sessions:           'users/sessions',
                                    omniauth_callbacks: 'users/omniauth_callbacks'  }
  
  resources  :photoposts,    only: [:show,:create, :destroy] do
    resources :comments, only: [:show, :create, :destroy]
  end
  resources  :relationships, only: [:create, :destroy]
  resources  :likes,         only: [:create, :destroy]
end


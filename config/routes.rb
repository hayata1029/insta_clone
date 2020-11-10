Rails.application.routes.draw do
  root to: 'staticpages#home'
  resources  :mypages,    only: [:show, :index]
  resources  :photoposts, only: [:create, :destroy]
  devise_for :users, controllers: { registraions: 'users/registraions',
                                    sessions: 'users/sessions',
                                    omniauth_callbacks: 'users/omniauth_callbacks'  }
  
end


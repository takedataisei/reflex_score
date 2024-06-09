Rails.application.routes.draw do
  devise_for :users
  root to: "communities#index"
  resources :users, only: [:show, :edit, :update]
  get 'communities/join', to: 'communities#join', as: 'join_community'
  post 'communities/join', to: 'communities#process_join'
  resources :communities, only: [:new, :create, :show, :edit, :update] do
    member do
      delete 'leave', to: 'communities#leave'
    end
  end
end

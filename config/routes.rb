Rails.application.routes.draw do
  devise_for :users
  root to: "communities#index"
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'communities/:community_id/evaluations', to: 'users#evaluations', as: 'community_evaluations'
    end
  end
  get 'communities/join', to: 'communities#join', as: 'join_community'
  post 'communities/join', to: 'communities#process_join'
  resources :communities, only: [:new, :create, :show, :edit, :update] do
    member do
      delete 'leave', to: 'communities#leave'
    end
    resources :evaluation_items, only: [:index, :create, :show, :destroy]
    resources :self_evaluations, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :peer_evaluations, only: [:new, :create, :index, :edit, :update, :destroy]
  end
end

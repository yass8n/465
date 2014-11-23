Rails.application.routes.draw do
  devise_for :users

  resources :posts do
  resources :ratings, shallow: true
  resources :comments, shallow: true
end

  root 'posts#index'
  
end

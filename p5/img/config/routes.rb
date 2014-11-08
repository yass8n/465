Rails.application.routes.draw do

  devise_for :users
resources :images do
  resources :tags, shallow: true
  resources :image_users, shallow: true
end
root to: 'images#index'
end

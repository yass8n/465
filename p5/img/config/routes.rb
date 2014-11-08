Rails.application.routes.draw do

  devise_for :users
resources :images do
  resources :tags, shallow: true
  resources :image_users, shallow: true
end
root to: 'images#index'
post 'images/:id/tags', to: "tags#create", as: "image_tag" #created this route so the form for creating tags works in the images show view
end

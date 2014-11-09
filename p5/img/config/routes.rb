Rails.application.routes.draw do

  devise_for :users
resources :images do
  resources :tags, shallow: true
  resources :image_users, shallow: true
end
root to: 'images#index'
post 'images/:id/tags', to: "tags#create", as: "image_tag" #created this route so the form for creating tags works in the images show view
post 'images/:id', to: "images#change_visibility", as: "change_visibility"
post '/images/:image_id/image_users/create/', to: 'image_users#create', as: 'create_image_user'
delete "/images/:image_id/image_users/destroy/", to: 'image_users#destroy', as: 'destroy_image_user'
get "/images/tag/search/", to: 'images#search_tag', as: 'image_tag_search'
get "/images/user/search/", to: 'images#search_user', as: 'image_user_search'
end

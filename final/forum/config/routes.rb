Rails.application.routes.draw do
	devise_for :users, :controllers => {:registrations => "users/registrations"}

    resources :posts do
	  resources :comments, shallow: true
	end
	resources :comments do
	  resources :ratings, shallow: true
	end

  root 'posts#index'
  
end

Rails.application.routes.draw do
	devise_scope :user do
	  delete "users/delete/pic/", to: "users/registrations#destroy_pic", as: "destroy_pic"
	end
	
	devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}

    resources :posts do
	  resources :comments, shallow: true
	end
	resources :comments do
	  resources :ratings, shallow: true
	end

	root 'posts#index'
	# delete 'users/pic/:id', to: "users/registrations#destroy_pic", as: "destroy_pic" 
  
end

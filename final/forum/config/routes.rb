Rails.application.routes.draw do
	devise_scope :user do
	  delete "users/delete/pic/", to: "users/registrations#destroy_pic", as: "destroy_pic"
	  get "users/recover/", to: "users/sessions#new", as: "recover_signin"
	  post "users/recover/", to: "users/registrations#recover", as: "recover_user"
	end
	
	devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}

    resources :posts do
	  resources :answers, shallow: true
	end
	resources :answers do
	  resources :ratings, shallow: true
	end

	root 'posts#index'
	# delete 'users/pic/:id', to: "users/registrations#destroy_pic", as: "destroy_pic" 
  
end

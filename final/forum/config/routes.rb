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

    get  "/comment/:id/edit", to: "commentarys#edit", as: "edit_comment" 
    post  "/users/:user_id/post/:post_id/comment/create", to: "commentarys#create_post_comment", as: "create_post_comment"
	post  "/users/:user_id/post/:post_id/answer/:answer_id/comment/create", to: "commentarys#create_answer_comment", as: "create_answer_comment" 
	# adding post id above so I can redirect to the post after creation
    patch "/comment/:id", to: "commentarys#update", as: "edit_commentary" 

end

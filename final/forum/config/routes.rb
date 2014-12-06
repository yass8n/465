Rails.application.routes.draw do
	devise_scope :user do
	  delete "users/delete/pic/", to: "users/registrations#destroy_pic", as: "destroy_pic"
	  get "users/recover/", to: "users/sessions#new", as: "recover_signin"
	  post "users/recover/", to: "users/registrations#recover", as: "recover_user"
      get "/user/search/", to: "users/registrations#search", as: 'user_search'
	  root 'users/registrations#new'
	end
	
	devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}

	# root 'posts#index'
    get  "/comment/:id/edit", to: "commentarys#edit", as: "edit_comment" 
    get  "/posts/user/:user_id/", to: "posts#my_posts", as: "my_posts" 
    get  "/answers/user/:user_id/", to: "answers#my_answers", as: "my_answers" 
    post  "/users/:user_id/post/:post_id/comment/create", to: "commentarys#create_post_comment", as: "create_post_comment"
	post  "/users/:user_id/post/:post_id/answer/:answer_id/comment/create", to: "commentarys#create_answer_comment", as: "create_answer_comment" 
    get "/posts/search/", to: 'posts#search', as: 'title_search'
	# adding post id above so I can redirect to the post after creation
    patch "/comment/:id", to: "commentarys#update", as: "edit_commentary" 
    post   "/ratings/create", to: "ratings#create", as: "create_rating"
    patch  "/ratings/:id/update", to: "ratings#update", as: "update_rating"
    resources :posts do
	  resources :answers, shallow: true
	end


end

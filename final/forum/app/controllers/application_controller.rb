class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_filter :authenticate!
	helper_method :get_rating, :get_pages #so the rating_form can call this function

	def authenticate!
		# :authenticate_user!

		# if u are trying to access any pages other than the sign in page and you are not a user, you are redirected to the login page
		if  current_user.nil? && protected_routes
			redirect_to new_user_session_path, alert: "Must sign in to proceed" and return
		end
		if params[:controller] == 'posts' && params[:id] && !params[:commit] == 'Search'
			current_post = Post.find(params[:id])
			if (params[:action] == 'edit' || params[:action] == 'update' || params[:action] == 'destroy')
			  if current_post.user == current_user
			    # when you return from authentication!, the program continues to requested page
			    return
			  else
			    # by redirecting here, we are preventing the user from visiting the requested page
			    redirect_to root_url, notice: "Record not found" and return
			  end
			end
		end
		if params[:controller] == 'answers' && params[:id] 
			current_answer = Answer.find(params[:id])
			if (params[:action] == 'edit' || params[:action] == 'update' || params[:action] == 'destroy')
			  if current_answer.user == current_user
			    # when you return from authentication!, the program continues to requested page
			    return
			  else
			    # by redirecting here, we are preventing the user from visiting the requested page
			    redirect_to root_url, notice: "Record not found" and return
			  end
			end
		end
	end

	def get_rating(resource, current_user_id)
		if resource.is_a?(Answer)
			return Rating.where(answer_id: resource.id, user_id: current_user_id)[0]
		elsif resource.is_a?(Post)
			return Rating.where(post_id: resource.id, user_id: current_user_id)[0]
		end
	end
	def get_pages(array)
		return (((array.count) -1) / 20) +1
	end

	protected
	def configure_permitted_parameters
	    registration_params = [:username, :recover, :state, :status, :filename, :country, :paypal_email, :email, :password, :password_confirmation]

		    if params[:action] == 'update'
		      devise_parameter_sanitizer.for(:account_update) { 
		        |u| u.permit(registration_params << :current_password)
		      }
		    elsif params[:action] == 'create'
		      devise_parameter_sanitizer.for(:sign_up) { 
		        |u| u.permit(registration_params) 
		      }
		end
	end

	# Overwriting the sign_out redirect path method
	def after_sign_out_path_for(resource_or_scope)
		new_user_session_path
	end
	def after_sign_in_path_for(resource)
		posts_path
	end

	def protected_routes
		return true if (params[:controller] == 'posts' && (params[:action] == "create" || params[:action] == "update" || params[:action] == "destroy" || params[:action] == "edit" || params[:action] == "new")) 
	    return true if (params[:controller] == 'answers' && (params[:action] == "create" || params[:action] == "update" || params[:action] == "destroy" || params[:action] == "edit" || params[:action] == "new")) 
		return true if (params[:controller] == 'ratings' && (params[:action] == "create" || params[:action] == "update" || params[:action] == "destroy" || params[:action] == "edit" || params[:action] == "new")) 
		return false #if not trying to access above routes
	end
end

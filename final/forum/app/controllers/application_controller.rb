class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	helper_method :get_rating #so the post.show.view can call this function

	def get_rating(comment_id, current_user_id)
		return Rating.where(comment_id: comment_id, user_id: current_user_id)[0]
	end

	protected
	def configure_permitted_parameters
	    registration_params = [:username, :paypal_email, :email, :password, :password_confirmation]

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
end

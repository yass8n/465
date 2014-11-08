class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate!
  before_filter :configure_devise_permitted_parameters, if: :devise_controller?

  protected
	def authenticate!
		:authenticate_user!

		if 	current_user.nil? && (params[:controller] == 'images' || params[:controller] == "tags" || params[:controller] == "image_users")
			redirect_to new_user_session_path
		end

		if params[:controller] == 'images' && (params[:action] == 'edit' || params[:action] == 'update' || params[:action] == 'destroy')
		  current_image = Image.find(params[:id])

		  if current_image.user == current_user
		    # when you return from authentication!, the program continues to requested page
		    return
		  else
		    # by redirecting here, we are preventing the user from visiting the requested page
		    redirect_to root_url, notice: "Record not found"
		  end
		end
	end

	  def configure_devise_permitted_parameters
	    registration_params = [:name, :email, :password, :password_confirmation]

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

end

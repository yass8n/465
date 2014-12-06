class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, only: [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]

  # GET /resource/sign_up

  def new
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    yield resource if block_given?
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    uploaded_pic = false
    if !params[:user].nil? && !params[:user][:uploaded_file].nil?
      resource.filename = resource.generate_filename
      uploaded_pic = true
    end
    resource.paypal_link = resource.create_paypal_link(params[:user][:paypal_email]) unless params[:user][:paypal_email].nil? || params[:user][:paypal_email].blank? 
    set_country_and_state unless params[:user][:country].nil? || params[:user][:country].blank? 
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      upload_pic if uploaded_pic
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      resource.remove_image_path
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource.paypal_link = resource.create_paypal_link(params[:user][:paypal_email]) unless params[:user][:paypal_email].nil? || params[:user][:paypal_email].blank? 
    set_country_and_state unless params[:user][:country].nil? || params[:user][:country].blank? 
    uploaded_pic = false
    if !params[:user].nil? && !params[:user][:uploaded_file].nil?
      resource.remove_image_path
      resource.filename = resource.generate_filename
      uploaded_pic = true
    end
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      upload_pic if uploaded_pic
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location:  edit_user_registration_path(resource)
    else
      clean_up resource
      clean_up_passwords resource
      respond_with resource
    end
  end
  def destroy_pic
    resource = User.find(params[:id])
    if ( resource.filename.nil? || resource.filename == "" )
      redirect_to edit_user_registration_path, alert: "An error occurred when processing your request" and return
    end
    resource.remove_image_path
    clean_up_passwords resource
    resource.save
    redirect_to edit_user_registration_path, notice: "Picture successfully deleted"
  end
  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  def search
        @title = params[:title].downcase
    @posts = Post.new.find_by_title(@title, params[:answered], params[:filter])
    @pages = get_pages(@posts)
    @current_page = params[:page].to_i
    if @title.nil? || @title.blank? || @posts.size == 0 || @current_page > @pages || @current_page < 1
      redirect_to posts_path(details_message: @details_message), alert: "No results. Check your spelling and filters then try again." and return
    else
    the_offset = (@current_page -1) * 20
    if the_offset+20 >= @posts.size 
      @posts = @posts[(@posts.size - (@posts.size - the_offset))...@posts.size]
    else
      @posts = @posts[the_offset...the_offset+20]
    end
    @details_message = ""
    if !params[:answered].nil? 
      if params[:answered] == "true"
        @details_message += "'Answered' only."
      else
        @details_message += "'Unanswered' only. "
      end
    end
    if !params[:filter].nil? 
        if params[:filter] == "recent"
          params[:filter] = "Most Recent"
        end
        if params[:filter] == "rating"
          params[:filter] = "Rating"
        end
        @details_message += " Sorted by '#{params[:filter]}.'"
      end
      render "posts/index", details_message: @details_message, current_page: @current_page, posts: @posts and return
    end
  end

  # Need to create a module for the states function below!
  def states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
  end
    # DELETE /resource
  def destroy
    if resource.valid_password?(params[:user][:current_password])
      resource.remove_image_path
      resource.set_to_deleted
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message :notice, :destroyed if is_flashing_format?
      resource.save
      yield resource if block_given?
      respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
    else
       redirect_to edit_user_registration_path, alert: "Password was incorrect" and return
    end
  end

  protected
  def set_country_and_state
    resource.country = params[:user][:country]
    if resource.country == "US"
      resource.state = params[:state] 
    else
      resource.state = nil
    end
  end
  def upload_pic
    @uploaded_io = params[:user][:uploaded_file]
    File.open(Rails.root.join('public', 'images', resource.filename), 'wb') do |file|
      file.write(@uploaded_io.read)
    end
  end

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end
  def clean_up(resource)
    resource.filename = nil
    resource.state = nil
    resource.country = nil
  end
  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end
  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy, :change_visibility]

  respond_to :html

  def index
    @images = Image.where(:public => true)
    @my_images = Image.where(:user_id => current_user.id)
    access_image_objects = ImageUser.all.where('user_id in (?)', current_user.id)
    @access_images =  access_image_objects.map do |object| Image.where(:id => object.image_id).first end #must add .first because we want the first object in the relation that is returned
    respond_with(@images, @my_images, @access_images)
  end

  def show
  	@tag = Tag.new #to create a new tag if the user wants to
    ids = ImageUser.all.map do |m| m.user_id if m.image_id == @image.id end #loops through all the accesses and returns all the user_ids of the accesses that this current image has
    ids.compact!
    ids << current_user.id #so the excluded users doent include the current user
    @excluded_users = User.all.where('id not in (?)',ids)
    ids.delete(current_user.id)
    @included_users = User.all.where('id in (?)',ids)
    respond_with(@image, @excluded_users, @included_users)
  end

  def new
    @image = Image.new
    respond_with(@image)
  end

  def edit
  end

  def change_visibility
      @image.public = !@image.public
      @image.public ? notice = "Image now public" : notice = "Image now private"
      if @image.save
        redirect_to image_path, notice: notice
      else
        redirect_to image_path, alert: "Image not updated"
      end
  end


# POST /images
  def create
    if params[:image].nil? || params[:image][:uploaded_file].nil?
    	redirect_to new_image_path, alert: "Please upload a photo"
    	return
    end
    if params[:public].nil?
    	redirect_to new_image_path, alert: "Stop trying to hack me, pick public or private!"
    	return
    end
    @image = Image.new(image_params)
    @image.filename = @image.generate_filename
    @image.user = current_user
    @image.public = params[:public]

    @uploaded_io = params[:image][:uploaded_file]

    File.open(Rails.root.join('public', 'images', @image.filename), 'wb') do |file|
        file.write(@uploaded_io.read)
    end

    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  def update
    if params[:public].nil?
      redirect_to new_image_path, alert: "Stop trying to hack me, pick public or private!"
      return
    end
    @image.public = params[:public]
    @uploaded_io = params[:image][:uploaded_file]
    File.open(Rails.root.join('public', 'images', @image.filename), 'wb') do |file|
        file.write(@uploaded_io.read)
      end

    @image.update(image_params)
    redirect_to @image, notice: 'Image was successfully updated.'
  end

  def destroy
    @image.destroy
    @image.tags.all.delete_all
    respond_with(@image)
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:filename, :public, :user_id)
    end
end

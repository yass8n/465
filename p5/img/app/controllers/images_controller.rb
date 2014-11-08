class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @images = Image.where(:public => true)
    respond_with(@images)
  end

  def show
  	@tag = Tag.new 
    respond_with(@image)
  end

  def new
    @image = Image.new
    respond_with(@image)
  end

  def edit
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
    @image.update(image_params)
    respond_with(@image)
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

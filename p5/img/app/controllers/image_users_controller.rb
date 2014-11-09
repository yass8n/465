class ImageUsersController < ApplicationController
  before_action :set_ImageUser, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ImageUsers = ImageUser.all
    respond_with(@ImageUsers)
  end

  def show
    respond_with(@ImageUser)
  end

  def new
    @ImageUser = ImageUser.new
    respond_with(@ImageUser)
  end

  def edit
  end

# POST /ImageUsers
  def create
    @ImageUser = ImageUser.new(image_id: params[:image_id], user_id: params[:user_id])
    user_name = User.find(params[:user_id].to_i).name
    image = Image.find(params[:image_id].to_i)
    if @ImageUser.save
      redirect_to image_path(image), notice: user_name + " was given access."
    else
       redirect_to image_path(image), alert: user_name + " was not given access."
    end
  end

  def update
    @ImageUser.update(ImageUser_params)
    respond_with(@ImageUser)
  end

  def destroy
    @ImageUser.destroy
    respond_with(@ImageUser)
  end

  private
    def set_ImageUser
      @ImageUser = ImageUser.find(params[:id])
    end

    def ImageUser_params
      params.require(:ImageUser).permit(:image_id, :user_id)
    end
end
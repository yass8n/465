class ImageUsersController < ApplicationController
  before_action :set_ImageUser, only: [:show, :edit, :update, :destroy, :create]

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
    if @ImageUser.save
      redirect_to image_path(@image), notice: @user_name.capitalize + " was given access."
    else
       redirect_to image_path(@image), alert: @user_name.capitalize + " was not given access."
    end
  end

  def update
    @ImageUser.update(ImageUser_params)
    respond_with(@ImageUser)
  end

  def destroy
    @ImageUser = ImageUser.where(image_id: params[:image_id], user_id: params[:user_id])
    if @ImageUser[0].destroy
      redirect_to image_path(@image), notice: @user_name + " no longer has access."
    else
      redirect_to image_path(@image), alert: "Error."
    end
  end

  private
    def set_ImageUser
      @user_name = User.find(params[:user_id].to_i).name
      @image = Image.find(params[:image_id].to_i)
    end

    def ImageUser_params
      params.require(:ImageUser).permit(:image_id, :user_id)
    end
end
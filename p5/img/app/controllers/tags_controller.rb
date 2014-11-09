class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tags = Tag.all
    respond_with(@tags)
  end

  def show
    respond_with(@tag)
  end

  def new
    @tag = Tag.new
    respond_with(@tag)
  end

  def edit
  end

# POST /tags
  def create
  	@image = Image.find params[:image_id]
    @tag = Tag.new(tag_params)
    @tag.image_id = @image.id

    if @tag.save
      redirect_to image_path(@image), notice: 'Tag was successfully created.'
    else
       redirect_to image_path(@image), alert: "Tag can't be empty."
    end
  end

  def update
    @tag.update(tag_params)
    respond_with(@tag)
  end

  def destroy
    @image = Image.find params[:image_id]
    view = params[:view]

    if view == "show"
      if @tag.destroy
        redirect_to image_path(@image), notice: 'Tag was successfully deleted.' 
      else
         redirect_to image_path(@image), alert: "Error."
      end
    end
    if view == "edit"
      if @tag.destroy
        redirect_to edit_image_path(@image), notice: 'Tag was successfully deleted.' 
      else
         redirect_to edit_image_path(@image), alert: "Error."
      end
    end
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:tag_string)
    end
end
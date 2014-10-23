class DoiObjectsController < ApplicationController
  before_action :set_doi_object, only: [:show, :edit, :update, :destroy, :all]
  require 'securerandom'

  def index
    @doi_objects = DoiObject.all
  end

  def show
     @url_object = @doi_object.url_objects.new
     @doi_object = [@doi_object]
  end

  def find
    @doi_object = DoiObject.where( [ "name LIKE ?" , "%#{params[:name]}%" ] )
    @render_url_form = false
    if params[:name].length < 1
      redirect_to doi_objects_path, alert: "Please enter a name."
    else
      render :show
    end
  end

  def all
     @url_objects =  UrlObject.where("doi_object_id = #{@doi_object.id}")
  end

  def edit
    @url_object =  UrlObject.where("doi_object_id = #{@doi_object.id}").last
  end

  def new
    @doi_object = DoiObject.new
    @doi_object.url_objects.new
  end

  def create
    @doi_object = DoiObject.new(doi_object_params)
    @doi_object.doi = SecureRandom.urlsafe_base64;
    #ensures unique DOI
   while DoiObject.find_by(doi: @doi_object.doi) do
       @doi_object.doi = SecureRandom.urlsafe_base64;
    end


    respond_to do |format|
      if @doi_object.save
        format.html { redirect_to @doi_object, notice: 'Doi was successfully created.' }
        format.json { render :show, status: :created, location: @doi_object }
      else
        format.html { render :new }
        format.json { render json: @doi_object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doi_object.update(doi_object_params)
        format.html { redirect_to @doi_object, notice: 'Doi was successfully updated.' }
        format.json { render :show, status: :ok, location: @doi_object }
      else
        format.html { render :edit }
        format.json { render json: @doi_object.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doi_object.destroy
    respond_to do |format|
      format.html { redirect_to doi_objects_path, notice: 'Doi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_doi_object
      @doi_object = DoiObject.find(params[:id])
    end

   def doi_object_params
      params.require(:doi_object).permit(:name, :description, url_objects_attributes: [:url])
  end
end

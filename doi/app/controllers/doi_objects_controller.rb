class DoiObjectsController < ApplicationController
  before_action :set_doi_object, only: [:show, :edit, :update, :destroy]
  require 'securerandom'


  # GET /doi_objects
  # GET /doi_objects.json
  def index
    @doi_objects = DoiObject.all
  end

  # GET /doi_objects/1
  # GET /doi_objects/1.json
  def show
    @url_objects =  UrlObject.where("doi_object_id = '25'")
  end

  # GET /doi_objects/new


  # GET /doi_objects/1/edit
  def edit
  end

  def new
    @doi_object = DoiObject.new
    @doi_object.url_objects.new
  end
  # POST /doi_objects
  # POST /doi_objects.json
  def create
    @doi_object = DoiObject.new(doi_object_params)
    @doi_object.doi = SecureRandom.urlsafe_base64;
    puts "................................................";
    puts @doi_object.url_objects;
    puts @doi_object.doi


    respond_to do |format|
      if @doi_object.save
        format.html { redirect_to @doi_object, notice: 'Doi object was successfully created.' }
        format.json { render :show, status: :created, location: @doi_object }
      else
        format.html { render :new }
        format.json { render json: @doi_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doi_objects/1
  # PATCH/PUT /doi_objects/1.json
  def update
    respond_to do |format|
      if @doi_object.update(doi_object_params)
        format.html { redirect_to @doi_object, notice: 'Doi object was successfully updated.' }
        format.json { render :show, status: :ok, location: @doi_object }
      else
        format.html { render :edit }
        format.json { render json: @doi_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doi_objects/1
  # DELETE /doi_objects/1.json
  def destroy
    @doi_object.destroy
    respond_to do |format|
      format.html { redirect_to doi_objects_url, notice: 'Doi object was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doi_object
      @doi_object = DoiObject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
 
   def doi_object_params
      params.require(:doi_object).permit(:name, :description, url_objects_attributes: [:url])
  end
end

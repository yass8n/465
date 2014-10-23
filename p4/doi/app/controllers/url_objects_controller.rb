# This controller does not have a show function
# since url_objects are shown by DoiObject, it does not make sense to
# show a single url_object

class UrlObjectsController < ApplicationController
  before_action :set_url_object, only: [:edit, :update, :destroy]

  def new
    # since our the url_object new path contains the DoiObject's id
    # we can use params[:DoiObject_id] to get that id
    @DoiObject = DoiObject.find params[:DoiObject_id]

    # This is similar to url_object.new, BUT it creates the new url_object
    # in the context of a DoiObject object and sets the foreign key
    @url_object = @DoiObject.url_objects.new
    render 'doi_objects/show'
  end

  # GET /url_objects/1/edit
  def edit
    @url_object =  UrlObject.find params[:id]
    # edit routes are not nested (we already know our DoiObject's foreign_key)
  end

  # POST DoiObjects:/:DoiObject_id/url_objects
  # we need the DoiObject's key in the URL to make sure that someone 
  # isn't trying to hack the id of the new url_object's DoiObject
  # rails ensures that the URL has not be tampered with
  def create
    @DoiObject = DoiObject.find params[:id]
    @url_object = @DoiObject.url_objects.new(url_object_params)

    if @url_object.save
      redirect_to doi_object_path(@DoiObject) , notice: 'URL was successfully created.'
    else
       redirect_to doi_object_path , alert: "URL can't be empty."
    end
  end

  # PATCH/PUT /url_objects/1
  # updates don't have to be nested because the DoiObject foreign key is already set
  # and cannot be changed by edit (note that DoiObject_id is not permitted in url_object_params())
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url_object
      @url_object = UrlObject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_object_params
      params.require(:url_object).permit(:url, :url_object)
    end
end
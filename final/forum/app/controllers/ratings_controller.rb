class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :set_post_and_comment, only: [:update, :create]

  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @rating = Rating.new
    @rating.user_id = params[:user_id]
    @rating.rate = params[:rate].to_i
    @rating.comment_id = params[:comment_id]
    @comment.rating_score += @rating.rate

    respond_to do |format|
      if @rating.save && @comment.save
        format.html { redirect_to @post, notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: 'Rating was NOT successfully created.' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    @rating.rate = params[:rate].to_i
    @comment.rating_score += @rating.rate * 2
    respond_to do |format|
      if @rating.save && @comment.save
        format.html { redirect_to @post, notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: 'Rating was NOT successfully updated.' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post_and_comment
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:comment_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:user_id, :rate, :comment_id)
    end
end

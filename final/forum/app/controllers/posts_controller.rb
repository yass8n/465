class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.new.get_posts(params[:page_offset])
    @pages = Post.new.get_pages(Array.new(Post.last.id+1))
    @the_offset = params[:page_offset].to_i
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @answer = Answer.new
    @answers = @answer.get_all_answers(@post.id)
    @answer_url = post_answers_path(@post)
    @comment = Commentary.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
   if @post.answers.size > 0 || @post.ratings.size > 0
      redirect_to @post, alert: "Can't edit/update post once it's been answered or rated." and return
    end 
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.answers.size > 0 || @post.ratings.size > 0
      redirect_to @post, alert: "Can't edit/update post once it's been answered or rated." and return
    end 
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # def destroy
  #   @post.destroy
  #   respond_to do |format|
  #     format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  def search_by_title
    @title = params[:title].downcase
    @posts = Post.new.find_by_title(@title, params[:answered], params[:filter])
    @pages = Post.new.get_pages(@posts)
    @the_offset = params[:page_offset].to_i
    if @the_offset+20 >= @posts.size 
      @posts = @posts[(@posts.size - (@posts.size - @the_offset))...@posts.size]
    else
      @posts = @posts[@the_offset...@the_offset+20]
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
    if @title.nil? || @title.blank? || @posts.size == 0
      redirect_to posts_path(details_message: @details_message), alert: "No results. Check your spelling and filters then try again." and return
    else
      render "posts/index", details_message: @details_message, the_offset: @the_offset, posts: @posts and return
    end

  end
  def my_posts
     @posts = Post.new.find_by_user_id(params[:user_id])
     if @posts.nil? || @posts.blank? || @posts.size == 0
      redirect_to posts_path(details_message: @details_message), alert: "You haven't created any posts yet." and return
    else
      @details_message = "My Posts"
      render "posts/index", details_message: @details_message, posts: @posts and return
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :content, :views, :title)
    end
end

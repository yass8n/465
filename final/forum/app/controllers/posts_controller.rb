class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
    @current_page = params[:page].to_i
    @posts = Post.new.get_posts((@current_page-1)*20)
    total = Post.last.id+1
    @pages = get_pages(Array.new(total))
    if (@current_page > @pages || @current_page < 1)
      flash[:error] = "Invalid page number"
      render "posts/index" and return
    end
    if (((@current_page-1) * 20)+1 == ((@current_page) * 20) - (20 - @posts.count) && total == ((@current_page-1) * 20)+1)
        @details_message = "Displaying last Post out of #{total} Posts"
      elsif total == 1
        @details_message = "Displaying your only Post"
      else
        @details_message = "Displaying #{((@current_page-1) * 20)+1} - #{((@current_page) * 20) - (20 - @posts.count)} of #{total} Post"
      end
      if total > 1
        @details_message += "s"
      end
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
    @pages = get_pages(@posts)
    @current_page = params[:page].to_i
    if (@current_page > @pages || @current_page < 1)
      flash[:error] = "Invalid page number"
      render "posts/index" and return
    end
    the_offset = (@current_page -1) * 20
    if the_offset+20 >= @posts.size 
      @posts = @posts[(@posts.size - (@posts.size - the_offset))...@posts.size]
    else
      @posts = @posts[the_offset...the_offset+20]
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
      render "posts/index", details_message: @details_message, current_page: @current_page, posts: @posts and return
    end

  end
  def my_posts
    total = Post.new.find_by_user_id(params[:user_id])
    @posts = total
    @pages = get_pages(@posts)
    @current_page = params[:page].to_i
    if (@current_page > @pages || @current_page < 1)
      flash[:error] = "Invalid page number"
      render "posts/index" and return
    end
    the_offset = (@current_page -1) * 20
    if the_offset+20 >= @posts.size 
      @posts = @posts[(@posts.size - (@posts.size - the_offset))...@posts.size]
    else
      @posts = @posts[the_offset...the_offset+20]
    end
     if @posts.nil? || @posts.blank? || @posts.size == 0
      redirect_to posts_path(details_message: @details_message), alert: "You haven't created any posts yet." and return
    else
      if (((@current_page-1) * 20)+1 == ((@current_page) * 20) - (20 - @posts.count) && total.count == ((@current_page-1) * 20)+1)
        @details_message = "Displaying last Post out of #{total.count} Posts"
      elsif total == 1
        @details_message = "Displaying your only Post"
      else
        @details_message = "Displaying #{((@current_page-1) * 20)+1} - #{((@current_page) * 20) - (20 - @posts.count)} of #{total.count} Post"
      end
      if total.count > 1
        @details_message += "s"
      end
      @my_posts = true
      render "posts/index", details_message: @details_message, current_page: @current_page, posts: @posts, my_posts: @my_posts and return
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if params[:id].to_i > Post.last.id || params[:id].to_i < 1
        redirect_to posts_path, alert: "Record not found." and return
      end
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :content, :views, :title)
    end
end

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :search_posts, :if => :resource_post?, :only => :search
  before_action :search_users, :if => :resource_user?, :only => :search
  
  # GET /posts
  # GET /posts.json
  def index
    @current_page = params[:page].to_i
    @current_page = 1 if params[:page].nil?
    @posts = Post.new.get_posts((@current_page-1)*20)
    total = Post.last.id
    @pages = get_pages(Array.new(total))
    if (@current_page > @pages || @current_page < 1)
      flash[:error] = "Invalid page number"
      render "posts/index" and return
    end
     @details_message = set_message(total, @current_page, @posts)
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
  def search
    if params[:resource].downcase == "posts"
      render "posts/index", details_message: @details_message, title_message:  @title_message, current_page: @current_page, posts: @posts and return
    else
      render "posts/index", details_message: @details_message, title_message:  @title_message, current_page: @current_page, posts: @posts and return
  end
  def my_posts
    total = Post.new.find_by_user_id(params[:user_id])
    @posts = total
    @pages = get_pages(@posts)
    @current_page = params[:page].to_i
    if ( (@current_page > @pages || @current_page < 1) && @pages != 0 )
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
      @details_message = set_message(total.count, @current_page, @posts)
      @title_message = "Displaying Your Posts:"
      @my_posts = true
      render "posts/index", details_message: @details_message, title_message:  @title_message, current_page: @current_page, posts: @posts, my_posts: @my_posts and return
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

    def search_posts
      @title = params[:title].downcase
        @posts = Post.new.find_by_title(@title, params[:answered], params[:filter])
        @pages = get_pages(@posts)
        total = @posts.size
        @current_page = params[:page].to_i
        if @title.nil? || @title.blank? || @posts.size == 0 || @current_page > @pages || @current_page < 1
          redirect_to posts_path(details_message: @details_message), alert: "No results. Check your spelling and filters then try again." and return
        else
        the_offset = (@current_page -1) * 20
          if the_offset+20 >= @posts.size 
            @posts = @posts[(@posts.size - (@posts.size - the_offset))...@posts.size]
          else
            @posts = @posts[the_offset...the_offset+20]
          end
        @title_message = ""
          if !params[:answered].nil? 
            if params[:answered] == "true"
            @title_message += "'Answered' only."
            else
            @title_message += "'Unanswered' only. "
            end
          end
        if !params[:filter].nil? 
          if params[:filter] == "recent"
            params[:filter] = "Most Recent"
          end
          if params[:filter] == "rating"
            params[:filter] = "Rating"
          end
        end
        @title_message = "Search Results for '#{@title.capitalize}':"
        @details_message = set_message(total, @current_page, @posts)
        end
      end
    end
  def search_users
    @username = params[:title].downcase
    @posts = Post.new.find_by_user(@username.downcase, params[:answered], params[:filter])
    total =  @posts.count
    @pages = get_pages(@posts)
    @current_page = params[:page].to_i
        if @username.nil? || @username.blank? || @posts.size == 0 || @current_page > @pages || @current_page < 1
          redirect_to posts_path(details_message: @details_message), alert: "No results. Check your spelling and filters then try again." and return
        else
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
        @title_message = "Displaying Posts By '#{@username}'"
        @details_message = set_message(total, @current_page, @posts)
      end
    end
    def resource_user?
      if params[:resource].nil? || params[:resource].downcase != "users"
        return false
      else
        return true
      end
    end
    def resource_post?
      if params[:resource].nil? || params[:resource].downcase != "posts"
        return false
      else
        return true
      end
    end
end

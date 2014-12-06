class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
    @answer_url = answer_path(@answer)
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.post_id = params[:post_id]
    @post = Post.find(params[:post_id])
    if @answer.you_already_answered
      #user already posted an answer before...cant post two answers to the same question
      redirect_to @post, notice: 'You have already answered this question before.' and return
    else
      respond_to do |format|
        if @answer.save
          format.html { redirect_to @post, notice: 'Answer was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { redirect_to post_path(@post), notice: "Can't have empty answer"}
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if params[:answer][:answer] == @answer.answer
      redirect_to edit_answer_path(@answer), notice: "No changes made." and return
    end
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.post, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def my_answers
    total = Answer.new.find_by_user_id(params[:user_id])
    @answers = total
    @pages = get_pages(@answers)
    @current_page = params[:page].to_i
    if ( (@current_page > @pages || @current_page < 1) && @pages != 0 )
      flash[:error] = "Invalid page number"
      render "answers/index" and return
    end
    the_offset = (@current_page -1) * 20
    if the_offset+20 >= @answers.size 
      @answers = @answers[(@answers.size - (@answers.size - the_offset))...@answers.size]
    else
      @answers = @answers[the_offset...the_offset+20]
    end
     if @answers.nil? || @answers.blank? || @answers.size == 0
      redirect_to posts_path(details_message: @details_message), alert: "You haven't answered any questions yet." and return
    else
      if (((@current_page-1) * 20)+1 == ((@current_page) * 20) - (20 - @answers.count) && total.count == ((@current_page-1) * 20)+1)
        @details_message = "Displaying last Answer out of #{total.count} Answer"
      elsif total == 1
        @details_message = "Displaying your only Answer"
      else
        @details_message = "Displaying #{((@current_page-1) * 20)+1} - #{((@current_page) * 20) - (20 - @answers.count)} of #{total.count} Answer"
      end
      if total.count > 1
        @details_message += "s"
      end
      render "answers/index", details_message: @details_message, current_page: @current_page, answers: @answers and return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:user_id, :post_id, :answer)
    end
end

class CommentarysController < ApplicationController
  before_action :set_commentary, only: [:edit, :update]
  before_action :set_post, only: [:create_post_comment, :create_answer_comment, :update, :edit]
  
  # GET /commentarys/1/edit
  def edit
  end

  # commentary /commentarys
  # commentary /commentarys.json
  def create_post_comment
    @commentary = Commentary.new(commentary_params)
    @commentary.post_id = params[:post_id]
    @commentary.user_id = params[:user_id]
    @commentary.answer_id = nil
    @commentary.comment = params[:commentary][:comment]

    respond_to do |format|
      if @commentary.save
        format.html { redirect_to @post, notice: 'Commentary was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: 'Commentary was NOT successfully created.'  }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
    def create_answer_comment
    @commentary = Commentary.new(commentary_params)
    @commentary.user_id = current_user.id

    respond_to do |format|
      if @commentary.save
        format.html { redirect_to @post, notice: 'Commentary was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commentarys/1
  # PATCH/PUT /commentarys/1.json
  def update
    respond_to do |format|
      if @commentary.update(commentary_params)
        format.html { redirect_to @commentary, notice: 'Commentary was successfully updated.' }
        format.json { render :show, status: :ok, location: @commentary }
      else
        format.html { render :edit }
        format.json { render json: @commentary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commentarys/1
  # DELETE /commentarys/1.json
  # def destroy
  #   @commentary.destroy
  #   respond_to do |format|
  #     format.html { redirect_to commentarys_url, notice: 'commentary was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commentary
      @commentary = Commentary.find(params[:id])
    end
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commentary_params
      params.require(:commentary).permit(:user_id, :comment, :post_id, :answer_id)
    end
end

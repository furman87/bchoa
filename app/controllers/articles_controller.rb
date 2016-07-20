class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:news, :rules, :welcome]
  layout Proc.new{ ['welcome'].include?(action_name) ? 'welcome' : 'application' }

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.order(:created_at)
  end

  def news
    @articles = Article.tagged_with("news").current.by_publish_date
  end

  def rules
    @articles = Article.tagged_with("rules").current.order(:id)
  end

  def welcome
    @articles = Article.tagged_with("welcome").current.by_publish_date.take(4)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = current_user.articles.build
    authorize_action_for(@article)
    session[:return_to] ||= request.referer
  end

  # GET /articles/1/edit
  def edit
    authorize_action_for(@article)
    session[:return_to] ||= request.referer
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to session.delete(:return_to), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    authorize_action_for(@article)
    session[:return_to] ||= request.referer
    @article.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:user_id, :title, :body, :start_date, :end_date, :tag_list, :sticky)
    end
end

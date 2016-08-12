class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:news, :rules, :welcome, :acc, :newsletters]
  layout Proc.new{ ['welcome'].include?(action_name) ? 'welcome' : 'application' }

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.by_publish_date.by_display_order
  end

  def acc
    get_articles("acc")
    @acc_chair = BoardMember.includes(:user).where(description: "ACC Chairperson").first
  end

  def documents
    get_articles("documents")
  end

  def minutes
    get_articles("minutes")
  end

  def news
    get_articles("news")
  end

  def newsletters
    get_articles("newsletters")
  end

  def rules
    get_articles("rules")
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
    @article = current_user.articles.build(start_date: Date.today, end_date: Date.today + 30, display_order: 1)
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
    @article = current_user.articles.build(article_params)
    # @article = Article.new(article_params)

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

    def get_articles(tag)
      @articles = Article.tagged_with(tag).current.by_display_order
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:user_id, :title, :body, :start_date, :end_date, :tag_list, :sticky, :display_order, article_assets_attributes: [:id, :asset, :description, :display_order, :_destroy])
    end
end

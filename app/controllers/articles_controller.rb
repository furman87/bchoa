class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_return_to, only: [:new, :edit, :destroy]
  before_action :authenticate_user!, except: [:news, :rules, :welcome, :acc, :newsletters]
  layout Proc.new{ ['welcome'].include?(action_name) ? 'welcome' : 'application' }

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.by_publish_date.by_display_order
  end

  def acc
    @articles = get_articles("acc")
    @acc_chair = BoardMember.includes(:user).where(description: "ACC Chairperson").first
  end

  def documents
    @articles = get_articles("documents")
  end

  def minutes
    @articles = get_articles("minutes")
  end

  def news
    @articles = get_articles("news")
  end

  def newsletters
    @articles = get_articles("newsletters")
  end

  def rules
    @articles = get_articles("rules")
  end

  def welcome
    @articles = get_articles("welcome").take(4)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = current_user.articles.build(start_date: Date.today, end_date: Date.today + 30, display_order: 1)
    authorize_action_for(@article)
  end

  # GET /articles/1/edit
  def edit
    authorize_action_for(@article)
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to session[:return_to] ? session.delete(:return_to) : root_path, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    authorize_action_for(@article)
    if @article.update(article_params)
      redirect_to session.delete(:return_to), notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    authorize_action_for(@article)
    @article.destroy
    redirect_to session.delete(:return_to), notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
    
    def set_return_to
      session[:return_to] ||= request.referer
    end

    def get_articles(tag, show_private = user_signed_in?)
      Article.tagged_with(tag).current.by_display_order.only_private(show_private)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:user_id, :title, :body, :start_date, :end_date, :tag_list, :sticky, :is_private, :display_order, article_assets_attributes: [:id, :asset, :description, :display_order, :_destroy])
    end
end

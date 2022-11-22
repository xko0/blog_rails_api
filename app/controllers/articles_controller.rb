class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  # GET /articles
  def index
    @articles = Article.all
    article_to_render = []
    @articles.each do |article|
      if !article.private || article.user == current_user
        article_to_render.push(article)
      end
    end
    render json: article_to_render
  end
  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if is_current_user?
      if @article.update(article_params)
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /articles/1
  def destroy
    if is_current_user?
      @article.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :private, :user_id)
    end

    def is_current_user
      @article.user == current_user
    end
end

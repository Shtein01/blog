class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret', except: [:index, :show]
  # attr_accessor :title

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    title = 'Article ' + (Article.last.id + 1).to_s
    @article = Article.new(title: title )
    # flash.now[:notice] = "Fleshka!"
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def copy
    article_old = Article.find(params[:id])
    @article = Article.new(title: article_old.title, body: article_old.body)
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    # @article = Article.all
    # render :index
    # redirect_to root_path
    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end

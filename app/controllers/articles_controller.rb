class ArticlesController < ApplicationController
  
  http_basic_authenticate_with name: "secret", password: "secret", except: [:index, :show]
  
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  
  def index
    @articles = Article.all
  end
  
  def edit
  end
  
  def show
  end
  
  def new
    @article = Article.new
  end
  
  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated."
      redirect_to @article
    else
      rende 'edit'
    end
  end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      flash[:notice] = "Article created."
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def destroy
    if @article.destroy
      flash[:notice] = "Article deleted."
    end
    redirect_to articles_path
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :text)
  end
end

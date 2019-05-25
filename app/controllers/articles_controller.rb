class ArticlesController < ApplicationController
 
before_action :set_article, only: [:edit, :update, :show, :destroy]

 def index
   @articles = Article.all
 end

  def new
 	@article = Article.new
  end

  def edit
    #@article = Article.find(params[:id]) we are calling this line in prviate path by defining def except create

  end

  def create
    #render plain: params[:article].inspect
    debugger
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
         flash[:success] = "Article was sucessfully created"
          redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
   # @article = Article.find(params[:id])
    if @article.update(article_params)
         flash[:success] = "Article was sucessfully update"
          redirect_to article_path(@article)
    else
     render 'edit'
     end      
  end

  def show
   # @article = Article.find(params[:id])
  end

  def destroy
   # @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article sucessfully Deleted"
    redirect_to articles_path
  end

  private
   def set_article
    @article = Article.find(params[:id])
   end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
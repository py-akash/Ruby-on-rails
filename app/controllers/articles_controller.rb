class ArticlesController < ApplicationController
 
before_action :set_article, only: [:edit, :update, :show, :destroy]
before_action :require_user, except: [:index, :show]           #user 20
before_action :require_same_user, only: [:edit, :update, :destroy]  #user 20

 def index
   @articles = Article.paginate(page: params[:page], per_page: 4)
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

  def require_same_user                   #user 20 from here
      if current_user != @article.user
        flash[:danger] = "you can only edit or delete your own article"
        redirect_to root_path
       end
  end
  #user 20 here

end
class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show] #after creating user 19
  before_action :require_same_user, only: [:edit, :update, :destroy]  #user 20 and user-22
  before_action :require_admin , only: [:destroy]  #user-22
    def index
    	@user = User.paginate(page: params[:page], per_page: 4)
    end

	def new
	 @user = User.new
	end

	def create
      @user = User.new(user_params)

      if @user.save
      	session[:user_id]= @user.id   #after application 
      	flash[:success] = "welcome to the Beta blog #{@user.username}"
      	#redirect_to articles_path  after application 
      	redirect_to user_path(@user)
      else
      	render 'new'
      end
	end

	def edit
		#@user = User.find(params[:id])  after creating user
	end
   

	def update
		#@user = User.find(params[:id])   after creating user
		if @user.update(user_params)
          flash[:success] = "your account updated sucessfully"
          redirect_to articles_path

		else
			render 'edit'
		end
	end

	def show 
	  # @user =User.find(params[:id])  after creating user
   @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end
      
      # add this destroy line of code in user-22
    def destroy
          @user = User.find(params[:id])
          @user.destroy
          flash[:danger] = "User and all articles created by user have been deleted"
          redirect_to users_path
    end


	private
	 def user_params
      params.require(:user).permit(:username, :email, :password)
	 end


	def set_user                        
		@user = User.find(params[:id])  
	end
 
 #user 20 from here
    def require_same_user
    	if current_user != @user and !current_user.admin?
    		flash[:danger] = "you can only edit or delete your own article"
             redirect_to root_path
         end
    end
    #user 20 here

    #user-22
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "only admin users can perform that action"
        redirect_to root_path
    end
    end
    #user-22
end


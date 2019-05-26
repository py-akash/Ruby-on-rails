class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show] #after creating user 19
  before_action :require_same_user, only: [:edit, :update]  #user 20 from
    def index
    	@user = User.paginate(page: params[:page], per_page: 4)
    end

	def new
	 @user = User.new
	end

	def create
      @user = User.new(user_params)

      if @user.save
      	flash[:sucess] = "welcome to the Beta blog #{@user.username}"
      	redirect_to articles_path
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
          flash[:sucess] = "your account updated sucessfully"
          redirect_to articles_path

		else
			render 'edit'
		end
	end

	def show 
	  # @user =User.find(params[:id])  after creating user
   @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
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
    	if current_user != @user
    		flash[:danger] = "you can only edit or delete your own article"
             redirect_to root_path
         end
    end
    #user 20 here
end


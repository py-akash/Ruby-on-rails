class PageController < ApplicationController

   def homepage
   	redirect_to articles_path if logged_in?  #user-19 
   end

   def about
   end

end
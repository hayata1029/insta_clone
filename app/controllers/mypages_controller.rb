class MypagesController < ApplicationController
  
   def index
      @users = User.all
   end
   
   def show
     @user = User.find(params[:id])
     @photoposts = @user.photoposts
   end
  
end

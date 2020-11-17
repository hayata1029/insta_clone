class MypagesController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers]

   def index
     @users = User.paginate(page: params[:page])
   end

   def show
     @user = User.find(params[:id])
     @photoposts = @user.photoposts
   end
   
   def following
     @title = "フォロー"
     @user  = User.find(params[:id])
     @users = @user.following
     render 'show_follow'
   end
   
   def followers
     @title = "フォロワー"
     @user  = User.find(params[:id])
     @users = @user.followers
     render 'show_follow'
   end
end


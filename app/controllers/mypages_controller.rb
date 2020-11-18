class MypagesController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers]

   def index
    #  @users = User.where(activated: true).search(params[:search])
    @users = User.all.search(params[:search])
   end

   def show
     @user = User.find(params[:id])
     @photoposts = @user.photoposts.search(params[:search])
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


class PhotopostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user,       only: :destroy
  
  def create
    @photopost = current_user.photoposts.build(photopost_params)
    if @photopost.save
      flash[:success] = "画像が投稿できました！"
      redirect_to mypage_url(current_user)
    else
      @feed_items = []
      flash[:danger] = "画像が投稿できませんでした…"
      redirect_to mypage_url(current_user)
    end
  end
  
  def destroy
    @photopost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end
  
  private
  
    def photopost_params
      params.require(:photopost).permit(:content, :picture)
    end
    
    def correct_user
      @photopost = current_user.photoposts.find_by(id: params[:id])
      redirect_to root_url if @photopost.nil?
    end
end



class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @photopost = Photopost.find(params[:photopost_id])
    unless @photopost.iine?(current_user)
      @photopost.iine(current_user)
      @photopost.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @photopost = Like.find(params[:id]).photopost
    if @photopost.iine?(current_user)
      @photopost.uniine(current_user)
      @photopost.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end

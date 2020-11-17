class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @photopost = Photopost.find(params[:photopost_id])
    unless @photopost.line?(current_user)
      @photopost.iine(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @photopost = Like.find(params[:id]).photopost
    if @photopost.line?(current_user)
      @photopost.uniine(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end

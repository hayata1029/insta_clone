class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :correct_user,       only: :destroy
  
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.photopost.id = params[:photopost_id]
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect @comment.photopost.id
    else
      @photopost = Photopost.find(params[:photopost_id])
      @comments = @photopost.comments
      render template: 'mypages/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_to @comment.micropost
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end

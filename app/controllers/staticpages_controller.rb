class StaticpagesController < ApplicationController
  def home
    if user_signed_in?
      @photopost  = current_user.photoposts.build 
      @feed_items = current_user.feed
    end
  end
end

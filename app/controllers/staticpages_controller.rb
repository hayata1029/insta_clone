class StaticpagesController < ApplicationController
  def home
    @photopost  = current_user.photoposts.build if user_signed_in?
    @feed_items = current_user.feed
  end
end

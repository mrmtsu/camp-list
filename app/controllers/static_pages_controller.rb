class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @log = Log.new
    end
  end

  def about
  end

  def terms
  end
end

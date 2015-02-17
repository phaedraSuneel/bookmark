class SiteController < ApplicationController
	require 'feedjira'
  def index
    @bookmarks = Bookmark.order('created_at desc').page(params[:page]) if current_user
  end
end

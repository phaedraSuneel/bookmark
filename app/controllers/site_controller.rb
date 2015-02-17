class SiteController < ApplicationController
	require 'feedjira'
  def index
  	feed = Feedjira::Feed.fetch_and_parse("http://feeds.feedburner.com/TechCrunch/")
    @entry = feed.entries.first(10)
    @bookmarks = Bookmark.order('created_at desc').page(params[:page]) if current_user
  end
end

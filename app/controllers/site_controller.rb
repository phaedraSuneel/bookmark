class SiteController < ApplicationController
	
  def index
  	feed = Feedjira::Feed.fetch_and_parse("http://feeds.feedburner.com/TechCrunch/")
    @entry = feed.entries.last(10)
    @bookmarks = Bookmark.order('created_at desc').page(params[:page]) if current_user
  end

end

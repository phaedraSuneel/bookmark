class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :fetch_rss_feeds



  protected

  def fetch_rss_feeds
    feed = Feedjira::Feed.fetch_and_parse("http://feeds.feedburner.com/TechCrunch/")
    @entry = feed.entries.first(10)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation, :current_password)
    end
  end
end

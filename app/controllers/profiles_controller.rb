class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow]
  def index
    @users = User.page(params[:page])
  end

  def show
    if @user
      @bookmarks = @user.bookmarks.page(params[:page])
      @followers =  @user.followers
      @followings = @user.followed_users
    else
      flash[:alert] = 'Profile not found.'
      redirect_to profiles_path
    end
  end

  def follow
    if current_user.follow(@user)
      flash[:notice] = "Follow successfully."
    else
      flash[:alert] = 'Action Failed.'
    end
    redirect_to :back  
  end

  def unfollow
    if current_user.unfollow(@user)
      flash[:notice] = "Unfollow successfully."
    else
      flash[:alert] = 'Action Failed.'
    end
    redirect_to :back  
  end

  private

    def set_user
      @user = User.where(username: params[:id]).first
    end

end

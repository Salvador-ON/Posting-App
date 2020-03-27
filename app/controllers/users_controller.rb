class UsersController < ApplicationController
  attr_accessor :users_list
  before_action :require_login

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def show
    @user = User.find(params[:id])

    @posts = Tweeet.where("user_id = ?", params[:id]).order("created_at DESC")
  
    #following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
    #@posts = Tweeet.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: current_user.id)
    @users_list = User.all
  end

  private
  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to '/' # halts request cycle
    end
  end
end

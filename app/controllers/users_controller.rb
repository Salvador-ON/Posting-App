class UsersController < ApplicationController
  attr_accessor :users_list
  

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
end

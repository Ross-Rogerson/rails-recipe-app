class UsersController < ApplicationController
  before_action :set_user, only: %i[ show follow unfollow followers following ]

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def summary
  end

  def follow
    current_user.following_relationships.create(following: @user) unless current_user.following.include?(@user)
    redirect_to user_path(@user)
  end
  
  def unfollow
    relationship = current_user.following_relationships.find_by(following: @user)
    relationship.destroy if relationship
    redirect_to user_path(@user)
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end
end

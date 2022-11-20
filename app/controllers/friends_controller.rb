class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ index show new edit create update destroy]

  def index
    @friends = Friend.all
  end

  def show
  end

  def new
    @friend = Friend.new
  end

  def edit
  end

  def create
    @friend = Friend.new(friend_params)

    if @friend.save
      current_user.friends << @friend
      FriendRequest.find_by(to: current_user.id).destroy
      flash[:success] = "You are now friends with this user"
      redirect_to root_url
    end
  end

  def update
      if @friend.update(friend_params)
        flash[:notice] = "Friend successfully updated"
        redirect_to root_url
      end
  end

  def destroy
    @friend.destroy
    flash[:danger] = "You unfriended this user"
    redirect_to friends_url
  end

  private
    def set_friend
      @friend = Friend.find(params[:id])
    end

    def friend_params
      params.require(:friend).permit(:user_id, :friend_with)
    end
end

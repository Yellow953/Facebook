class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ index show new edit create update destroy]

  def index
    @friend_requests = FriendRequest.all
  end

  def show
  end

  def new
    @friend_request = FriendRequest.new
  end

  def edit
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
      if @friend_request.save
        flash[:notice] = "Friend request was successfully created."
        redirect_to root_url(@comment)
      end
  end

  def update
      if @friend_request.update(friend_request_params)
        flash[:notice] = "Friend request was successfully updated."
        redirect_to root_url(@comment)
      end
  end

  def destroy
    @friend_request.destroy
    flash[:notice] = "Friend request was successfully destroyed."
    redirect_to root_url(@comment)
  end

  private
    def set_friend_request
      @friend_request = FriendRequest.find(params[:id])
    end

    def friend_request_params
      params.require(:friend_request).permit(:from, :to)
    end
end
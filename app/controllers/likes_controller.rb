class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ index show new edit create update destroy]

  def index
    @likes = Like.all
  end

  def show
  end

  def new
    @like = Like.new
  end

  def edit
  end

  def create
    @like = Like.new(like_params)
      if @like.save
        @user = current_user
        @user.likes << @like 
      end
  end

  def update
      if @like.update(like_params)
        flash[:notice] = "Like was successfully updated."
        redirect_to root_url(@comment)
      end
  end

  def destroy
    @like.destroy
    flash[:notice] = "Like was successfully destroyed."
    redirect_to root_url(@comment)
  end

  private
    def set_like
      @like = Like.find(params[:id])
    end

    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
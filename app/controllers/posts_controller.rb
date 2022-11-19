class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ index show new edit create update destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if params[:post][:image]
      @post.image.attach(params[:post][:image])
    else
      @post.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'rails.png')), filename: 'rails.png', content_type: 'image/png')
    end
      if @post.save
        flash[:notice] = "Post was successfully created."
        redirect_to root_url(@comment)
      end
  end

  def update
      if @post.update(post_params)
        flash[:notice] = "Post was successfully updated."
        redirect_to root_url(@comment)        
      end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post was successfully destroyed."
    redirect_to root_url(@comment)      
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :text, :user_id)
    end
end
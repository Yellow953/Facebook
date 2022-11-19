class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ index show new edit create update destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

      if @comment.save
        flash[:notice] = "Comment was successfully created."
        redirect_to root_url(@comment)
      end
  end

  def update
      if @comment.update(comment_params)
        flash[:notice] = "Comment was successfully updated."
        redirect_to root_url(@comment)
      end
  end

  def destroy
    @comment.destroy
    flash[:danger] = "comment successfully deleted"
    redirect_to root_url
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text, :user_id, :post_id)
    end
end

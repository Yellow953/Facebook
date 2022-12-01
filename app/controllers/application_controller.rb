class ApplicationController < ActionController::Base
    before_action :authenticate_user!, only: %i[ comments profile edit_user users user_requests]


    def index
        if  params.require(:/).permit(:user, :likes, :from, :to)
            puts params[:user]
            @feed = Post.where(user_id: params[:user]).paginate(page: params[:page], per_page: 25)
        else
            @feed = Post.paginate(page: params[:page], per_page: 25)
        end
        @like = Like.new
    end
    
    def comments
        @post = Post.find_by(id: params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end
    
    def profile
        @user = User.find_by(name: params[:name]) || current_user
        @users = User.all
    end

    def edit_user
        @user = current_user
        if @user.update params.require(:user).permit(:username, :phone)
            flash[:warning] = "you updated your values"
        end
        if params[:image]
            @user.image.attach(params[:image])
        end   
    end
   
    def users
        @query = User.ransack(params[:q])
        @result = @query.result(distinct: true)
        @friend_request = FriendRequest.new 
    end
    
    def user_requests
        @users = User.all
        @requests = FriendRequest.all
        @friend = Friend.new
    end
end
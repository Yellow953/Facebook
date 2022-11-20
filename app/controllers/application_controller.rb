class ApplicationController < ActionController::Base
    before_action :authenticate_user!, only: %i[ comments profile edit_user users user_requests]


    def index
        @feed = Post.all
        @like = Like.new
    end
    
    def comments
        @post = Post.find_by(id: params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end
    
    def profile
        @user = current_user
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
        if params[:email]
            @result = User.where("email LIKE ?", "%" + params[:email] + "%")
        else
            @result = User.all
        end  
        @friend_request = FriendRequest.new 
    end
    
    def user_requests
        @users = User.all
        @requests = FriendRequest.all
        @friend = Friend.new
    end
end
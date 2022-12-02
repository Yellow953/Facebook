class ApplicationController < ActionController::Base
    before_action :authenticate_user!, only: %i[ comments profile edit_user users user_requests]

    def index
        if  params[:user] || params[:likes] || params[:from] || params[:to]    
            if params[:likes] != ""
                res = []
                posts = Post.all
                posts.each do |post|
                    if post.likes.count.to_i >= params[:likes].to_i
                        res.append(post)
                    end
                end
                @feed = Post.where(id: res).paginate(page: params[:page], per_page: 25)
            elsif params[:from] != ""
                @feed = Post.where('created_at >= :from', :from => params[:from]).paginate(page: params[:page], per_page: 25)
            elsif params[:to] != ""
                @feed = Post.where('created_at <= :to', :to => params[:to]).paginate(page: params[:page], per_page: 25)
            elsif params[:from] != "" && params[:to] != ""
                @feed = Post.where(:created_at => params[:from]..params[:to]).paginate(page: params[:page], per_page: 25)
                @comments = Comment.where(:created_at => @selected_date.beginning_of_day..@selected_date.end_of_day)
            elsif params[:likes] != ""
                @feed = ""
            elsif params[:user]!= ""
                @feed = Post.where(user_id: params[:user]).paginate(page: params[:page], per_page: 25)
            end    
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
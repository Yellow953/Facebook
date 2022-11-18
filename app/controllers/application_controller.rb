class ApplicationController < ActionController::Base
    before_action :authenticate_user!, only: %i[ index comments profile edit_user ]


    def index
        @feed = Post.all
    end
    
    def comments
        @post = Post.find_by(id: params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end
    
    def profile
        @user = current_user
    end

    def edit_user
        @user = current_user
        if @user.update user_params
            flash[:warning] = "you updated your values"
        end
        if params[:image]
            @user.image.attach(params[:image])
        end
        
    end
   
    private

    def user_params
        params.permit(:email, :username, :phone)
    end

end
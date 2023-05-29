class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.place_id = params["place_id"]
  end

  def create
    if current_user
      @post = Post.new(post_params)
      @post.user_id = current_user.id

      if @post.save
        redirect_to "/places/#{params["post"]["place_id"]}"
      else
        flash.now["notice"] = "Failed to create the post."
        render :new
      end
    else
      flash["notice"] = "Please log in to create a post."
      redirect_to login_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :posted_on, :place_id)
  end

  def require_login
    unless current_user
      flash["notice"] = "Please log in to create a post."
      redirect_to login_path
    end
  end
end

# def create
#   if @current_user
#     @post = Post.new
#     @post["body"] = params["post"]["body"]
#     @post["image"] = params["post"]["image"]
#     @post["user_id"] = @current_user["id"]
#     @post.save
#   else
#     flash["notice"] = "Login first."
#   end
#   redirect_to "/posts"
# end

# end
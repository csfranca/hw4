class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.place_id = params["place_id"]
  end

  def create
    if current_user
      @post = Post.new(post_params)
      @post.uploaded_image.attach(params["post"]["uploaded_image"])
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

class Post < ApplicationRecord
  has_one_attached :uploaded_image
end
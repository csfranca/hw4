class PostsController < ApplicationController

  def show
    @post = Post.find_by({"id" => params["id"]})
    @place = Place.find_by({"id" => @post["place_id"]})
    # render posts/show view with details about Post
  end

  def new
    @post = Post.new
    @post["place_id"] = params["place_id"]
    # render posts/new view with new Post form
  end

  def create
    # start with a new Post
    @post = Post.new

    puts params["post"]

    # assign user-entered form data to Contact's columns
    @post["title"] = params["post"]["title"]
    @post["user_id"] = params["post"]["user_id"]
    @post["description"] = params["post"]["description"]
    @post["posted_on"] = params["post"]["posted_on"]
    @post["created_at"] = params["post"]["created_at"]
    @post["updated_at"] = params["post"]["updated_at"]

    # assign relationship between Post and Place
    @post["place_id"] = params["post"]["place_id"]

    # save Post row
    @post.save

    # redirect user
    redirect_to "/places/#{@post["place_id"]}"
  end

end
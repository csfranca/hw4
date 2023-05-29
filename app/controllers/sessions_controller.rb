class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email" => params["email"]})
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome!"
        redirect_to "/places"
      else
        flash["notice"] = "Incorrect information. Please try again"
        redirect_to "/sessions/new"
      end
    else
    flash["notice"] = "Incorrect login information. Please try again"
    redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Logged out"
    redirect_to "/sessions/new"

  end
end
  
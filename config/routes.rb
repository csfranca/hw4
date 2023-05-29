Rails.application.routes.draw do
  get "/", :controller => "places", :action => "index"
  resources "places"
  resources "posts"
  resources "sessions"
  resources "users"
  get "/logout", :controller => "sessions", :action => "destroy"
end

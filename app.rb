require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'pry'


set :database, "sqlite3:main.sqlite3"
set :sessions, true

# links index
get '/' do
	erb :index
end

# links signup page
get '/signup' do
	erb :signup
end

# prints signup page
post '/signup' do
	User.create(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password], email: params[:email])
	redirect '/'
end

# gets id of user and prints their specific homepage
get '/:id' do
	@person = User.find(params[:id])
	@blogs = Blog.all
	erb :home
end

# checks params of username/password and allows login if values match
post '/login'  do
    @username = params[:username]
    @password = params[:password]

	if
		person = User.where(username: @username, password: @password).first
	    session[:user_id] = person.id
			name = person.username
	  redirect "/#{person.id}"
	else
	  redirect '/'
	end
end

# links id of user and prints their specific settings page
get '/:id/settings' do
	@person = User.find(params[:id])
	erb :settings
end

# prints the updated user params and then redirects to that users homepage
post '/update_user' do
  person = User.find(session[:user_id])
  person.update(fname: params[:fname], lname: params[:lname], email: params[:email], username: params[:username], password: params[:password])
  # we needd to add something here that will disallow the user from entering blank fields
  redirect "/#{person.id}"
end

post "/delete_user" do
  person = User.find(session[:user_id])
  person.destroy
  redirect '/'
end

# prints the blog post to the page after clicking "submit" and then shows that specific users blog posts 
post "/create_blog" do
	person = User.find(session[:user_id])
	Blog.create(content: params[:content], user_id: person.id, username: person.username)
	redirect "/#{person.id}"
end

# gets the blog post from one specific user id and prints it to the blogs page ???
# get '/:id/blogs' do
# 	erb :blogs
# end

# gets the blog post from one specific user id and prints it to the home page...
# need to figure out how to link this to the profile.erb page
get '/blogs/:id' do
	@blog = Blog.find(params[:id])
	erb :profile
end

# gets the user id and prints their "friends" (all other users) to the friends page
get '/:id/friends' do	
	# Imports the person variable so that the friends page can be accessed
	@person = User.find(params[:id])
	@users = User.all
	erb :friends
end

# creates the appearance of logging out but truly just redirects to the index/main login page
post '/logout' do
	session[:user_id] = nil
	redirect "/"
end

# gets the profile of the current user and prints it to the profile page
get '/profile/:id' do
  @person = User.find(params[:id])
  @blog = @person.blogs
  erb :"/profile"
end







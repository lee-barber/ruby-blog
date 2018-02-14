require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:development.sqlite3"
set :sessions, true

get '/' do 
	@blogs = Blog.all
erb :home	
end

post '/create_users' do
	User.create(username: params[:username], password: params[:password])
	redirect '/'
end

get "/users/new" do
erb :"users/new"
end

get "/users" do
	@users = User.all
erb :"users/index"
end
	
get '/users/:id' do
@user = User.find(params[:id])
erb :'users/show'
end

post '/signin'  do
	@username = params[:username]
	@password = params[:password]
if 
 user = User.where(username: @username, password: @password).first
	session[:user_id] = user.id
	# here for interpolation you always need to user double quotes
	redirect "/users/#{user.id}"
	else
		redirect '/'
	end	
end

get '/users/:id/edit' do
@user = User.find(session[:user_id])
erb :'users/edit'
end


post '/update_user' do
user = User.find(session[:user_id])
user.update(username: params[:username], password: params[:password])	
redirect "/users/#{user.id}"
end

post "/delete_user" do
user = User.find(session[:user_id])
user.destroy
redirect '/'
end

post '/logout' do
session[:user_id] = nil
redirect "/"
end


post "/create_blog" do 
user = User.find(session[:user_id])	
Blog.create(title: params[:title], content: params[:content], user_id: user.id)
redirect '/'
end


get '/blogs/:id' do
@blog = Blog.find(params[:id])
erb :blog
end






































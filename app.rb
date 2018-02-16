require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'pry'


set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do
	erb :index
end

get '/signup' do
	erb :signup
end

post '/signup' do
	User.create(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password], email: params[:email])
	redirect '/'
end

get '/:id' do
	@person = User.find(params[:id])
	@blogs = Blog.all
	erb :home
end

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

get '/:id/account' do
	@person = User.find(params[:id])
	erb :account
end

post "/create_blog" do
	user = User.find(session[:user_id])
	Blog.create(content: params[:content], username: user.username, user_id: user.id)
	redirect "/#{user.id}"
end

get '/:id/blogs' do
	erb :blogs
end

get '/blogs/:id' do
	@blog = Blog.find(params[:id])
	erb :home
end
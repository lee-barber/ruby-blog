require 'sinatra'
require 'sinatra/activerecord'
require './models'


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
erb :home
end

post '/login'  do
    @username = params[:username]
    @password = params[:password]
if
person = User.where(username: @username, password: @password).first
    session[:user_id] = person.id
    redirect "/#{person.id}"
    else
        redirect '/'
    end
end




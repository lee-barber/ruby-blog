# ----Monday 2/12/18 (Edited)----------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------

# Setup

# Go to terminal and create a directory

mkdir folder 

cd folder

# touch the app.rb, models.rb, Gemfile, and Rakefile

touch app.rb models.rb Gemfile Rakefile

# mkdir a "views" folder then cd into the "views" folder

mkdir views

cd views

# touch index.erb inside the "views" folder

touch index.erb

# ------------------------------------------------------------------

# Open the project folder in Sublime

cd ..

subl .

# In the Gemfile, type the gems you are going to be using, e.g.

source "https://www.rubygems.org"

gem 'sinatra'
gem 'sqlite3'
gem 'sinatra-activerecord'
gem 'rake'

# ------------------------------------------------------------------

# In the app.rb file, type which gems you need, what database to use, and where to find the index file (index.erb)

require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"

get '/' do
	erb :index
end

# ------------------------------------------------------------------

# In the Rakefile folder, 

require './app'

require 'sinatra/activerecord/rake'

# ------------------------------------------------------------------

# Go to the terminal and navigate to root folder of project then type:

# this installs all of the gems that were required from the Gemfile

bundle install

# Confirm that the files are all linked (e.g. print "Hello world")...

# Go to the index.erb file (views>index.erb) and type some HTML (e.g. <h2>Hellow world</h2>)

# Start the server in the terminal (ruby app.rb) and confirm that "Hello world" prints

# Now go to the terminal and type:

rake db:create_migration NAME=create_blogs_table

# "blogs" in "create_blogs_table" is ambiguous... change "blogs" to the plural version of whatever table you are creating

# Do not for get to write the (s) in "create_blogs_table"

# The "blogs" in "create_blogs_table" is ambiguous... you need to change "blogs" to whatever it corresponds with in the models.rb file, e.g. if you have "Post" and "User" in the models.rb file then you need "create_posts_table" and "create_users_table" *** Make note that "Post" becomes PLURAL when it goes from models.rb to the terminal rake command "create_posts_table".

# this will create a database called "blogs" (or whatever was in the string "create_XXXXXXXX_table") and create a new folder within the project file (e.g. "sinatra-db") called "db"

# Navigate to db>migrate>000000000_create_blogs_table.rb file in Sublime

# Use this file to define what the structure of the table will look like, e.g.:

### DO NOT COPY PASTE ###
### MUST EDIT "Blogs" IN "CreateBlogsTable" first to match what you named the table previously when it was "raked"

class CreateBlogsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :blogs do |t|
  		t.string :title
  		t.string :content
  		t.string :category
    end
  end
end

# ------------------------------------------------------------------

# After setting up the table, go back to the terminal and type:

rake db:migrate

# This will create a file called 'schema.rb' in the 'db>migrate' folder and a 'main.sqlite3' file in the root folder

# The 'main.sqlite3' file is just a bunch of hexcode which isn't really that useful

# You should see lines like ================== in the terminal... "this is always a good sign" after you do "rake", e.g.:

# Lees-MacBook-Air:sinatra-rb2 kozmo$ rake db:migrate
# == 20180213162251 CreateBlogsTable: migrating =================================
# -- create_table(:blogs)
#    -> 0.0010s
# == 20180213162251 CreateBlogsTable: migrated (0.0011s) ========================

# *** Never edit the schema.rb file *** 
# (similar to how when you style with SASS you no longer touch the CSS file)

# After you have created a table, you can't add more to the table in the db>migrate>000000000_create_blogs_table.rb file... you have to add any additional attributes (e.g. t.string :location) via the terminal

# *** If you mix up the above code you may have to start your project over from scratch ***

# ------------------------------------------------------------------

# Go to the models.rb file and type:

### DO NOT COPY PASTE ###
### MUST EDIT "Blog" in "CreateBlogsTable" first!

class Blog < ActiveRecord::Base

end

# "Blog" is ambiguous in this case, change "Blog" to match your specific table

# ------------------------------------------------------------------

# Go back to terminal and type:

irb

# Once IRB is initialized, type:

require "./app"

# Then type:

Blog.all # (Jeremy says "Blog.all" may not always be necessary??)

# You should get a return that has colored text and says something like: 

# Blog Load (0.9ms)  SELECT  "blogs".* FROM "blogs" LIMIT ?  [["LIMIT", 11]]

# From IRB, add a new record by typing:

Blog.create(title: 'All about wine', content: 'lorem ipsum', category: 'alcohol')

# You should get a return that has colored text and says something like:

# D, [2018-02-12T14:25:38.932996 #3619] DEBUG -- :    (0.1ms)  begin transaction
# D, [2018-02-12T14:25:38.934860 #3619] DEBUG -- :   SQL (0.6ms)  INSERT INTO "blogs" ("title", "content", "category") VALUES (?, ?, ?)  [["title", "All about wine"], ["content", "lorem ipsum"], ["category", "alcohol"]]
# D, [2018-02-12T14:25:38.937303 #3619] DEBUG -- :    (2.0ms)  commit transaction
#  => #<Blog id: 1, title: "All about wine", content: "lorem ipsum", category: "alcohol"> 
# 2.4.1 :005 >

# Add another record and then type:

Blog.all

# You should now see the previous record in addition to the one you just added

# Return value after adding 2 records should look something like:

# D, [2018-02-12T14:31:16.320293 #3619] DEBUG -- :   Blog Load (0.3ms)  SELECT  "blogs".* FROM "blogs" LIMIT ?  [["LIMIT", 11]]
#  => #<ActiveRecord::Relation [#<Blog id: 1, title: "All about wine", content: "lorem ipsum", category: "alcohol">, #<Blog id: 2, title: "Stuff about cookies", content: "Cookies are good", category: "food">]> 
# 2.4.1 :009 > 

# Go to the app.rb file and under the section "get '/' do", add:

@blogs = Blog.all
	
# missed a whole bunch of info ... got distracted and couldn't keep up

# :(

# :(

# :(

# To create a new entry in a database, you can't edit the schema file or the 092349203984.db file, you have to do it from the command line in the terminal.  Open the terminal and navigate to the root of the project, then type: (e.g)

rake db:create_migration NAME=add_user_id_to_blogs_table
# the "add_user_id_to_blogs_table" is ambiguous

# Navigate to the new 098230498230948.db file that was created in the migrate folder (e.g. migrate>20180212203949_add_user_id_to_blogs_table.rb)

# The file should start with:

class AddUserIdToBlogsTable < ActiveRecord::Migration[5.1]


# You need to add input after "def change", e.g.

class AddUserIdToBlogsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :blogs, :user_id, :integer
  end
end

# Go back to terminal project root folder and type:

rake db:migrate

# Restart the Ruby server on the terminal and refresh the page to view changes

# ------------------------------------------------------------------

# Extra help from Oggi but will learn this tomorrow...
## How to delete entries ##

# Go to root of project folder via terminal

# Type:

irb

# Type:

require './app'

# Type:

Post.last
# ("Post" is ambiguous, use whatever is specific to current project)

# Type:

p.destroy


# ----Tuesday 2/13/18------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------

# How to update an entry

# from IRB:

# this will return the user with Primary Key "3"
user = User.find(3)

# type "User" to confirm that IRB shows the user with Primary Key "3"
User

# type this syntax to update the entry
user.update(fname: "Bill")


# Now we are going to create Relational Databases...

# Create a Foreign Key (as opposed to Primary Key)

# Foreign Key is a field in the table that will track a specific users input

# To add a new field to a database, you cannot modify the 2018021317939_create.rb file, you need to create a new field via the terminal

# Go back to root folder of project in terminal and type:

rake db:create_migration NAME=add_user_id_to_blogs_table

# This will create a new 234982304983_create...rb file in the db>migrate folder

# Go to the new table.rb file and add the column you'd like to enter, e.g.

class AddUserIdToBlogsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :user_id, :integer
  end
end

# The only line you are changing above is "add_column: blogs, :user_id, :integer"

# Navigate to the models.rb file and add the "has_many" lines, e.g.

class User < ActiveRecord::Base
  has_many :blogs, dependent: :destroy
end

class Blog < ActiveRecord::Base
  has_many :user
end

# "has many" is not syntax-specific, it is a database thing

# How to check user-specific entries:

# Go to terminal and start IRB, then type:

require './app'

# Then type:

u = User.first

u.blogs

u2 = User.find(2)

# All of this could be typed this way instead?

User.find(1).blogs

# ------------------------------------------------------------------
# Afer lunch break...

# Creating a login page

# Make a page in the "views" folder called "login.erb"

# On the app.rb page, change the erb :index to erb :login so that the first page that loads is the login page instead of the index, e.g.

get '/' do
  erb :login
end

# Type all of your HTML and form stuff on the login.erb page, e.g.

<h3>Welcome to the login page</h3>

<form action='/login' method='post'>
  <input type="text" name="fname" placeholder="First Name">
  <input type="text" name="laname" placeholder="Last Name">
  <input type="text" name="age" placeholder="Age">
  <input type="submit" value="Login">
</form>


# Add "set :sessions, true" to the app.rb file, e.g.

require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do
  erb :login
end

post '/login' do

end

# Add the following to the app.rb file after "post '/login' do", e.g.:

user = User.where(fname: params[:fname])
  if user.lname = params[:laname]
    session [:user_id] = user.id
    redirect '/profile'
  else
    redirect '/'
  end

# '/profile' is ambiguous in the above clip... this can be changed to wherever you would like to direct the user after they successfully login

# After you've made the necessary changes, your app.rb file should look like this:

require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do
  erb :login
end

post '/login' do
user = User.where(fname: params[:fname])
  if user.lname = params[:laname]
    session [:user_id] = user.id
    redirect '/profile'
  else
    redirect '/'
  end
end

# Go back to the "views" folder and create a "profile.erb" page

# After creating a "profile.erb" page, add the following to the app.rb file:

get '/profile' do
  @user = User.find(session[:user_id])
erb :index
end

# Once finished, the entire app.rb file should now look like this:

require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do
  erb :login
end

post '/login' do
user = User.where(fname: params[:fname])
  if user.lname = params[:laname]
    session [:user_id] = user.id
    redirect '/profile'
  else
    redirect '/'
  end
end

get '/profile' do
  @user = User.find(session[:user_id])
erb :index
end

# Go to IRB and create a new user... e.g.

User.create(fname: "John", laname: "Smith", age: 30)

# ------------------------------------------------------------------

# How to Edit a User

# Create an "edit.erb" file in the "views" folder

# Copy/paste the content/functionality of the login.erb page

# The edit.erb file will look something like this:

<h3>Edit page</h3>

<form action='/login' method='post'>
  <input type="text" name="fname" placeholder="First Name">
  <input type="text" name="laname" placeholder="Last Name">
  <input type="text" name="age" placeholder="Age">
  <input type="submit" value="Submit">
</form>

# Go back to the app.rb file and add the following to the "get /profile do":

@user.update(fname: params[:fname], lname: params[:laname], age: params[:age])
  redirect '/'

# When finished, the "get /profile do section should look like this:"

get '/profile' do
  @user = User.find(session[:user_id])
erb :index
end

# You also want to create a "post" functionality for when the user is updated, e.g.

post '/update' do
  @user = User.find(session[:user_id])
  @user.update(fname: params[:fname], lname: params[:laname], age: params[:age])
  redirect '/'
end

# The entire app.rb file should now look like this:

require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do
  erb :login
end

post '/login' do
user = User.where(fname: params[:fname]).first
  if user.laname == params[:laname]
    session[:user_id] = user.id
    redirect '/profile'
  else
    redirect '/'
  end
end

get '/profile' do
  @user = User.find(session[:user_id])
erb :index
end

post '/update' do
  @user = User.find(session[:user_id])
  @user.update(fname: params[:fname], lname: params[:laname], age: params[:age])
  redirect '/'
end

# Now were are doing something else... not sure what.

# Put the following code in between the "get '/profile' do" and the "post '/update' do" code
  
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :edit
end

# When finished, the entire app.rb file should look like this:

require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:main.sqlite3"
set :sessions, true

get '/' do
  erb :login
end

post '/login' do
user = User.where(fname: params[:fname]).first
  if user.laname == params[:laname]
    session[:user_id] = user.id
    redirect '/profile'
  else
    redirect '/'
  end
end

get '/profile' do
  @user = User.find(session[:user_id])
erb :index
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :edit
end

post '/update' do
  @user = User.find(session[:user_id])
  @user.update(fname: params[:fname], lname: params[:laname], age: params[:age])
  redirect '/'
end

# ------------------------------------------------------------------

# How to Delete a User

# Go back to the edit.erb file and add something like this to the bottom...

<h4>Delete user</h4>

<form action="/destroy_user" method="post">
  <input type="submit" value="Delete account">
</form>

# Go to the app.rb file and add this to the bottom of the page...

post "/destroy_user" do
  user = User.find(session[:user_id])
  @user.destroy
  redirect '/'
end




class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
  		create_table :users do |x|
  		x.string :username
  		x.string :password
  		x.string :fname
  		x.string :lname
  		x.string :email
  	end
  end
end

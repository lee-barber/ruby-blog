class AddUsernameToBlogsTable < ActiveRecord::Migration[5.1]
  def change
  	add_column :blogs, :username, :string
  end
end
class CreateBlogsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :blogs do |x|
  		x.string :content
	end
  end
end
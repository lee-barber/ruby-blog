class User < ActiveRecord::Base
	# validates :username, uniqueness: true, presence: true
has_many :blogs, dependent: :destroy
end


class Blog < ActiveRecord::Base
belongs_to :user
end
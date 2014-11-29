class Commentary < ActiveRecord::Base
	 belongs_to :user
	 belongs_to :answer
	 belongs_to :post
	 validates :user_id, presence: true
	 validates :comment, presence: true
end

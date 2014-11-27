class Commentary < ActiveRecord::Base
	 belongs_to :user, :answer, :post
	 validates :user_id, presence: true
	 validates :comment, presence: true
end

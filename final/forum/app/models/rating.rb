class Rating < ActiveRecord::Base
  belongs_to :comment
  validates :user_id, presence: true
  validates :comment_id, presence: true
  validates :rate, presence: true

  def find_rating(comment_id, current_user_id)
  	return Rating.where(comment_id: comment_id, user_id: current_user_id)
  end
  
end

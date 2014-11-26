class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :ratings
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :comment, presence: true
  before_create :init_rating_score
  
  def current_user_rating(current_user, rating)
	return nil if rating.nil?
  	return Rating.where(user_id: current_user.id, comment_id: self.id)[0].rate
  end
  def get_comments(offset_value, post_id)
    return Comment.where(post_id: post_id).limit(20).offset(offset_value.to_i - 1)
  end
  def get_comment_pages(post_id)
    return (Comment.where(post_id: post_id).count / 20) + 1
  end
  private
  def init_rating_score
  	self.rating_score = 0
  end
end

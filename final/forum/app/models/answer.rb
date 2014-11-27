class Answer < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :ratings
  has_many :commentarys
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :answer, presence: true
  before_create :init_rating_score
  
  def current_user_rating(current_user, rating)
	return nil if rating.nil?
  	return Rating.where(user_id: current_user.id, answer_id: self.id)[0].rate
  end
  def get_all_answers(post_id)
    return Answer.where(post_id: post_id)
  end

  private
  def init_rating_score
  	self.rating_score = 0
  end
end

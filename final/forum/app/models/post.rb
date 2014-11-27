class Post < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :ratings
  has_many :commentarys
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true

  def get_answers(offset_value)
  	return Answer.where(post_id: self.id).limit(10).offset(offset_value)
  end
end

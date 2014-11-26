class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :ratings
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true

  def get_comments(offset_value)
  	return Comment.where(post_id: self.id).limit(10).offset(offset_value)
  end
end

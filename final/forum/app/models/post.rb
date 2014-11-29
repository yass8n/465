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
  def find_by_title(title, answered, filter)
    posts = Post.all.select { |post| /#{title}/i =~ post.title}
    unless answered.nil?
      if answered == "true"
         posts = posts.select { |post| post.answers.size > 0 }
      else
         posts = posts.select { |post| post.answers.size == 0 }
      end 
    end
    return posts
  end
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :ratings
  has_many :commentarys
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
  before_create :init_rating_score
  def get_posts(offset_value)
    return Post.order('created_at DESC').limit(20).offset(offset_value.to_i - 1)
  end
  def get_pages(posts)
    return ((posts.count-1) / 20) + 1
  end
  def calculate_rating
    ratings = Rating.all.where(post_id: self.id)
    total = 0
    ratings.each do |rate| 
      total += rate.rate
    end
    return total
  end
  def init_rating_score
    self.rating_score = 0
  end
  def get_answers(offset_value)
  	return Answer.where(post_id: self.id).limit(10).offset(offset_value)
  end
  def current_user_rating(current_user, rating)
  return nil if rating.nil?
    return Rating.where(user_id: current_user.id, post_id: self.id)[0].rate
  end
  def find_by_user_id(user_id)
    return Post.where(user_id: user_id).reverse
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
    unless filter.nil?
      if filter == "rating"
         posts = Post.order(rating_score: :desc);
         posts = posts.select { |post| /#{title}/i =~ post.title }
      elsif filter == "oldest"
        return posts
      end
    end
    posts.reverse!
    return posts
  end
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :ratings
  validates :user_id, presence: true
end

class Comment < ActiveRecord::Base
  belongs_to :post
  validates :user_id, presence: true
  validates :content, presence: true
end

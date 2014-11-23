class Rating < ActiveRecord::Base
  belongs_to :comment
  validates :user_id, presence: true
  validates :comment_id, presence: true
  validates :rate, presence: true

end

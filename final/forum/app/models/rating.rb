class Rating < ActiveRecord::Base
  belongs_to :post
  validates :user_id, presence: true
end

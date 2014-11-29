class Rating < ActiveRecord::Base
  belongs_to :answer
  belongs_to :post
  validates :user_id, presence: true
  validates :rate, presence: true

end

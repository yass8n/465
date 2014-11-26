class Rating < ActiveRecord::Base
  belongs_to :answer
  validates :user_id, presence: true
  validates :answer_id, presence: true
  validates :rate, presence: true

end

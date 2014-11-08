class Image < ActiveRecord::Base
  belongs_to :user
  has_many :image_users
  has_many :users, through: :image_users
  has_many :tags
end

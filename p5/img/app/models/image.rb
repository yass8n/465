class Image < ActiveRecord::Base
require 'securerandom'
  belongs_to :user
  has_many :image_users
  has_many :users, through: :image_users
  has_many :tags
  validates :user_id, presence: true

	def generate_filename
		filename = SecureRandom.hex + ".jpg"
		#ensures unique filename
		while Image.find_by(filename: filename) do
			filename = SecureRandom.hex + ".jpg"
		end
		return filename
	end

end

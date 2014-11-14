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
	def can_view(current_user)
		if ((self.users.include? current_user) || (self.user == current_user)) 
			return true
		else
			return false
		end
	end
	def remove_image_path
		path = Rails.root.join('public', 'images', self.filename)
		File.delete(path)
	end
	def visibility(current_user)
		if self.public == true
			return "Public"
		elsif (self.public == false && (self.users.include? current_user))
			return "Shared"
		else
			return "Private"
		end
	end
	def remove_users
		ImageUser.where(image_id: self.id).each do |image_user| image_user.destroy end
	end
	def remove_tags
		self.tags.each do |tag| tag.destroy end
	end
end

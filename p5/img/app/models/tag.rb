class Tag < ActiveRecord::Base
  belongs_to :image
  validates :image_id, presence: true
  validates :tag_string, presence: true
end

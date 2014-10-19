class DoiObject < ActiveRecord::Base
	 has_many :url_objects, dependent: :destroy
	 accepts_nested_attributes_for :url_objects
	 validates_uniqueness_of :doi
	 validates :name, presence: true
end

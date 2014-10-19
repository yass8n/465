class UrlObject < ActiveRecord::Base
  belongs_to :doi_object

  validates :url, presence: true
end

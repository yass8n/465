class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  require 'securerandom'
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :paypal_email, :allow_nil => true, :allow_blank => true
  validates :username, presence: true
  validates :email, presence: true
  validates :paypal_email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :country, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  before_create :status_active
    def status_active
    	self.status = "active"
    end
	def create_paypal_link(email)
		return nil if email == "" || email.nil? 
	  	link = "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business="
	    paypal_email = email
	    paypal_email = paypal_email.gsub("@", "%40")
	    paypal_email = paypal_email.gsub(".", "%2e")
	    paypal_email = paypal_email.gsub("-", "%2d")
	    paypal_email = paypal_email.gsub("!", "%21")
	    paypal_email = paypal_email.gsub("$", "%24")
	    paypal_email = paypal_email.gsub("&", "%26")
	    paypal_email = paypal_email.gsub("'", "%E2%80%98")
	    paypal_email = paypal_email.gsub("*", "%2a")
	    paypal_email = paypal_email.gsub("+", "%2b")
	    paypal_email = paypal_email.gsub("-", "%2d")
	    paypal_email = paypal_email.gsub("=", "%3d")
	    paypal_email = paypal_email.gsub("?", "%3f")
	    paypal_email = paypal_email.gsub("^", "%5e")
	    paypal_email = paypal_email.gsub("`", "%60")
	    paypal_email = paypal_email.gsub("{", "%7b")
	    paypal_email = paypal_email.gsub("|", "%7c")
	    paypal_email = paypal_email.gsub("}", "%7d")
	    paypal_email = paypal_email.gsub("~", "%7e")
	    link += paypal_email
	    link += "&lc=US&no_note=0&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHostedGuest"
	    return link
	def is_nil
		return paypal_email.nil?
	end
	end
	def generate_filename
		filename = SecureRandom.hex + ".jpg"
		#ensures unique filename
		while User.find_by(filename: filename) do
			filename = SecureRandom.hex + ".jpg"
		end
		return filename
	end
	def remove_image_path
		if ( !self.filename.nil? && self.filename != "")
			path = Rails.root.join('public', 'images', self.filename)
			File.delete(path)
		    self.filename = ""
		end
	end
	def set_to_deleted
	    self.status = "deleted"
	end
	  
end

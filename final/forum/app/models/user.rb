class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :paypal_email
  validates :username, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	def create_paypal_link(email)
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
	end
end

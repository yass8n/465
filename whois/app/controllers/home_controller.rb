class HomeController < ApplicationController

	def index
		# don't need to do anything here
	end

	def show
		@query_text = params[:query]
		if @query_text =~ /^[a-zA-Z0-9\.\-]*$/
			@result = `echo #{@query_text}`
		else
			@result = ["Illegal URL"];
		end
	end

end

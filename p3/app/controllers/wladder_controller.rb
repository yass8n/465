class WladderController < ApplicationController

load "#{Rails.root}/lib/ladder.rb"
load "#{Rails.root}/lib/words4.rb"

	def index
		#setting class variable and instance variable  so we can get the same value later in the 'show' function
		@@step0 = @step0= dictionary.sample 
		@@goal = @goal = dictionary.sample
		while(@goal == @step0) do
			@goal = dictionary.sample
		end
	end
	def show
		@step0 = @@step0
		@goal = @@goal
		#strip getting rid of trailing white space
		@step1 = params[:step1].strip
		@step2 = params[:step2].strip
		@step3 = params[:step3].strip
		@step4 = params[:step4].strip
		@step5 = params[:step5].strip
		#getting rid of empty values in the form
		@steps_array = [@step1, @step2, @step3, @step4, @step5].reject! do |steps| steps.empty? end 
		if (legal(@steps_array) && edit_distance_of_one(@step0, @steps_array[0]) && edit_distance_of_one(@goal, @steps_array[@steps_array.length-1]))
			@result = "YOU WIN!"
		else
			@result = "YOU LOSE!"
		end
	end
end

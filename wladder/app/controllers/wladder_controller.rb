class WladderController < ApplicationController

load "#{Rails.root}/lib/ladder.rb"
load "#{Rails.root}/lib/words4.rb"
 def initialize
 		@step0 = dictionary.sample
		@goal = dictionary.sample
 end
	def index
		while(@goal == @step0) do
			@goal = dictionary.sample
		end
	end
	def show
		@step1 = params[:step1]
		@step2 = params[:step2]
		@step3 = params[:step3]
		@step4 = params[:step4]
		@step5 = params[:step5]
		@steps_array = [@step1, @step2, @step3, @step4, @step5].reject! do |steps| steps.empty? end
		if (legal(@steps_array) && edit_distance_of_one(@step0, @steps_array[0]) && edit_distance_of_one(@goal, @steps_array[@steps_array.length-1]))
			@result = "YOU WIN!"
		else
			@result = "YOU LOSE!"
		end
	end
end

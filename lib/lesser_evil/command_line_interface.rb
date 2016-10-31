class LesserEvil::CommandLineInterface

	def initialize
	end
  
  def input_validation(valid_array)
  	first_iteration = true
  	input = ''
    while !valid_array.include?(input)
    	print "\nInvalid input. Try again. " unless first_iteration
    	first_iteration = false
    	input = gets.chomp.downcase
    end
    input
  end

	def call
    puts "LESSER EVIL\n"
    print "Trump or Clinton? Choose a candidate: "
    candidate = input_validation(['trump','clinton'])
    print "Angry or very angry? "
    very_angry = input_validation(['angry','very angry']) == 'very angry'
    tweets = LesserEvil::TweetController.new.get_tweets(candidate,very_angry)
    tweets.each do |tweet|
    	puts tweet["text"]
    end
	end

end

class LesserEvil::CommandLineInterface

	def initialize
	end
  
  def input_validation(valid_array)
  	input = gets.chomp.downcase
    while !valid_array.include?(input)
    	print "\nInvalid input. Try again. "
    	input = gets.chomp.downcase
    end
    input
  end

	def call
    puts "LESSER EVIL\n"
    print "Trump or Clinton? Choose a candidate: "
    candidate = input_validation(['trump','clinton'])
    # candidate = 'trump' # debug
    print "Angry or very angry? "
    very_angry = input_validation(['angry','very angry']) == 'very angry'
    # very_angry = false # debug
    start = Time.now
    tweets = LesserEvil::TweetController.new.get_tweets(candidate,very_angry)
    # tweets.each {|tweet_slim| tweet_slim.prettyprint }
    puts "\n#{Time.now - start}"
	end

end

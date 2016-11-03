class LesserEvil::CommandLineInterface

	def initialize
	end

	def intro_display
		20.times { puts }

		File.open("assets/hillary.txt", "r") do |file|
			file.readlines.each do |line|
				print line.white.on_black
				sleep 0.05
			end
		end

		puts 

		File.open("assets/donald.txt", "r") do |file|
			file.readlines.each do |line|
				print line.white.on_black
				sleep 0.05
			end
		end

		puts
		puts "-----------------------------------".red
		puts "LESSER EVIL  ••••••••••••••••••••••".red
		puts
		puts "Peruse the angriest election tweets".red
		puts "-----------------------------------\n\n\n".red
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
    intro_display
    print "Trump or Clinton? Choose a candidate: "
    candidate = input_validation(['trump','clinton'])
    # candidate = 'trump' # debug
    print "Angry or very angry? "
    very_angry = input_validation(['angry','very angry']) == 'very angry'
    # very_angry = false # debug
    start = Time.now # debug
    tweets = LesserEvil::TweetController.new.get_print_tweets(candidate,very_angry,"Negative")
    # tweets.each {|tweet_slim| tweet_slim.prettyprint }
    puts "\n#{Time.now - start}" # debug
	end

end

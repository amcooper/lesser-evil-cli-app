class LesserEvil::CommandLineInterface

	def initialize
	end

	def intro_display
		20.times { puts }

		File.open(File.join(File.dirname(__FILE__), "/../assets/hillary.txt"), "r") do |file|
			file.readlines.each do |line|
				print line.white.on_black
				sleep 0.05
			end
		end

		puts "\n\n" 
		

		File.open(File.join(File.dirname(__FILE__), "/../assets/donald.txt"), "r") do |file|
			file.readlines.each do |line|
				print line.white.on_black
				sleep 0.05
			end
		end

		puts "\n\n"
		puts "-----------------------------------".red
		puts "LESSER EVIL  ••••••••••••••••••••••".red
		puts
		puts "Peruse the angriest election tweets".red
		puts "-----------------------------------\n\n\n".red
	end
  
  def input_validation(valid_array)
  	input = gets.chomp.downcase
    while !valid_array.include?(input) do
    	print "\nInvalid input. Try again. "
    	input = gets.chomp.downcase
    end
    input
  end

	def call

    intro_display
    exit = nil

    while !exit do
	    print "Trump or Clinton? Choose a candidate: "
	    candidate = input_validation(['trump','clinton'])
	    print "Angry or very angry? "
	    very_angry = input_validation(['angry','very angry']) == 'very angry'
	    puts "\n\n"
	    tweets = LesserEvil::TweetController.new(candidate: candidate, is_intense: very_angry, sentiment: "Negative", fast_print: true).get_print_tweets
	    puts "\n\n"
	    print "New batch? (yes/no): "
	    exit = input_validation(['y','yes','n','no']).start_with?('n')
		end

	  puts "O.K.! Take it easy."

	end

end

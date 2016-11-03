class TweetSlim

	attr_accessor :text, :author, :timestamp, :id

	def initialize(status)
		@text = status["text"]
		@author = status["user"]["screen_name"]
		@timestamp = status["created_at"]
		@id = status["id"]
	end

	def prettyprint
		  puts
		  puts @text.white
    	puts "@#{@author} #{@timestamp}".blue
    	# binding.pry
    	# puts "-------------------".red
  end

end
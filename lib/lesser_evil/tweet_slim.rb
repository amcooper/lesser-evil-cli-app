class TweetSlim

	attr_accessor :text, :author, :timestamp, :id

	def initialize(status)
		@text = status["text"]
		@author = status["author"]
		@timestamp = status["timestamp"]
		@id = status["id"]
	end

	def prettyprint
		  puts
		  puts @text.white
    	puts "@#{@author} #{@timestamp}".blue
    	# puts "-------------------".red
  end

end
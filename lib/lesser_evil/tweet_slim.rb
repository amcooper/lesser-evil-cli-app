class TweetSlim

	attr_accessor :text, :author, :timestamp

	def initialize(text,author,timestamp)
		@text = text
		@author = author
		@timestamp = timestamp
	end

	def prettyprint
		  puts @text.white
    	puts "@#{@author} #{@timestamp}".blue
    	puts "-------------------\n".red
  end

end
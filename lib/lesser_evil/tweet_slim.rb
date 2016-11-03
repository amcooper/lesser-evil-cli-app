class TweetSlim

	attr_accessor :text, :author, :timestamp, :id

	def initialize(text,author,timestamp,id)
		@text = text
		@author = author
		@timestamp = timestamp
		@id = id
	end

	def prettyprint
		  puts
		  puts @text.white
    	puts "@#{@author} #{@timestamp}".blue
    	# puts "-------------------".red
  end

end
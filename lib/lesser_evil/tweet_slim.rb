class TweetSlim

	attr_accessor :text, :author, :timestamp, :id, :candidate

  @@all = {}

	def initialize(candidate,status)
		@text = status["text"]
		@author = status["user"]["screen_name"]
		@timestamp = status["created_at"]
		@id = status["id"]
		@candidate = candidate
	end

	def save
		if @@all.empty? || self.id
		end
	end

	def prettyprint
		  puts
		  puts @text.white
    	puts "@#{@author} #{@timestamp}".blue
    	# binding.pry
    	# puts "-------------------".red
  end

end
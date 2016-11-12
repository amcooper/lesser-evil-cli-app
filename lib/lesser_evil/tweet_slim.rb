class TweetSlim

	attr_accessor :text, :author, :timestamp, :id, :candidate, :orig_id

	def initialize(candidate,status)
		@text = status["text"]
		@author = status["user"]["screen_name"]
		@timestamp = status["created_at"]
		@id = status["id"]
		@candidate = candidate
		@orig_id = status["retweeted_status"] == nil ? nil : status["retweeted_status"]["id"]
	end

	def prettyprint
		  puts @text.light_black
    	puts "@#{@author} #{@timestamp}".light_blue
	end

end
class TweetSlim

	attr_accessor :text, :author, :timestamp

	def initialize(text,author,timestamp)
		@text = text
		@author = author
		@timestamp = timestamp
	end
	
end
class LesserEvil::TweetController

	def initialize
	end

	def print_message
		puts "Tweet controller message"
	end

	def get_tweets(candidate,very_angry)
		response = HTTParty.get('https://api.twitter.com/1.1/search/tweets.json?q=Hillary+Clinton&count=4', headers: {"Authorization" => "Bearer AAAAAAAAAAAAAAAAAAAAAPztxgAAAAAAqq0aDjAjGtwkizqhV8wwLdKQB9I%3DY1wGPKUWSz7LV94M2VHBwHle7I3kW46WRmCEgIaZZS6GNTCqwn"})
		# binding.pry
		response["statuses"]
	end
end
class LesserEvil::TweetController

	attr_accessor :result

	LesserEvil::BASE_URL = "https://api.twitter.com/1.1/search/tweets.json"
	LesserEvil::APP_AUTH = "Bearer AAAAAAAAAAAAAAAAAAAAAPztxgAAAAAAqq0aDjAjGtwkizqhV8wwLdKQB9I%3DY1wGPKUWSz7LV94M2VHBwHle7I3kW46WRmCEgIaZZS6GNTCqwn"
	LesserEvil::SEARCH_TERMS = {
		clinton: "'Hillary+Clinton'+%23ImWithHer+lang:en",
		trump: "'Donald+Trump'+-Jr+%23MAGA+OR+%23MakeAmericaGreatAgain+lang:en"
	}
	LesserEvil::TWEET_QTY = 21
	LesserEvil::BATCH_QTY = 100

	def initialize
		@result = []
	end

	def get_batch(candidate,very_angry,max_id = nil)
		response = HTTParty.get("#{LesserEvil::BASE_URL}?q=#{LesserEvil::SEARCH_TERMS[candidate.to_sym]}&count=#{LesserEvil::BATCH_QTY}&max_id=#{max_id}", headers: {"Authorization" => LesserEvil::APP_AUTH})
		# binding.pry
		response["statuses"]
	end

	def get_sentiment(text)
		options = { body: { txt: text }}
		response = HTTParty.post("http://sentiment.vivekn.com/api/text/", options)
		# binding.pry
		response["result"]
	end

	def get_tweets(candidate,very_angry)
		max_id = nil
		while result.length < LesserEvil::TWEET_QTY
			batch = get_batch(candidate,very_angry,max_id)
			max_id = batch.last["id"] - 1
			batch.each do |status|
				print ': '
				sentiment_analysis = get_sentiment(status["text"])
				# puts sentiment_analysis["sentiment"], sentiment_analysis["confidence"] #debug
				if sentiment_analysis["sentiment"] == "Negative" && result.length < LesserEvil::TWEET_QTY
					@result << TweetSlim.new(status["text"],status["user"]["screen_name"],status["created_at"])
				end        
			end
			print "#{result.length}, " #debug
		end
		puts
		@result
	end

end
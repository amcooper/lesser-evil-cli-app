class LesserEvil::TweetController

	LesserEvil::BASE_URL = "https://api.twitter.com/1.1/search/tweets.json"
	LesserEvil::APP_AUTH = "Bearer AAAAAAAAAAAAAAAAAAAAAPztxgAAAAAAqq0aDjAjGtwkizqhV8wwLdKQB9I%3DY1wGPKUWSz7LV94M2VHBwHle7I3kW46WRmCEgIaZZS6GNTCqwn"
	LesserEvil::SEARCH_TERMS = {
		clinton: "Hillary+Clinton",
		trump: "Donald+Trump"
	}
	LesserEvil::TWEET_QTY = 21
	LesserEvil::BATCH_QTY = 40

	def initialize
	end

	def get_batch(candidate,very_angry,max_id = nil)
		response = HTTParty.get("#{LesserEvil::BASE_URL}?q=#{LesserEvil::SEARCH_TERMS[candidate.to_sym]}&count=#{LesserEvil::BATCH_QTY}&max_id=#{max_id}", headers: {"Authorization" => LesserEvil::APP_AUTH})
		binding.pry
		response["statuses"]
	end

	def get_sentiment(text)
		options = { body: { txt: text }}
		response = HTTParty.post("http://sentiment.vivekn.com/api/text/", options)
		# binding.pry
		response["result"]
	end

	def get_tweets(candidate,very_angry)
		result = []
		max_id = nil
		while result.length < LesserEvil::TWEET_QTY
			batch = get_batch(candidate,very_angry,max_id)
			max_id = batch.last["id"] - 1
			batch.each do |status|
				sentiment_analysis = get_sentiment(status["text"])
				puts sentiment_analysis["sentiment"], sentiment_analysis["confidence"]
				if sentiment_analysis["sentiment"] == "Negative" && result.length < LesserEvil::TWEET_QTY
					result << TweetSlim.new(status["text"],status["user"]["screen_name"],status["created_at"])
				end        
			end
			done = true
		end
		result
	end

end
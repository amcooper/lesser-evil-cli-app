class LesserEvil::TweetController

	attr_accessor :result, :candidate, :is_intense, :sentiment, :fast_print, :tweet_qty, :batch_qty

	def initialize(options)
		@result = []
    @candidate = options[:candidate]
    @is_intense = options[:is_intense]
    @sentiment = options[:sentiment] || "Negative"
    @fast_print = options[:fast_print] == nil ? true : options[:fast_print]
    @tweet_qty = options[:tweet_qty] || LesserEvil::DEFAULT_TWEET_QTY
    @batch_qty = options[:batch_qty] || LesserEvil::DEFAULT_BATCH_QTY
	end

	def get_batch(candidate,is_intense,max_id = nil)
		response = HTTParty.get("#{LesserEvil::BASE_TWITTER_URL}?q=#{LesserEvil::SEARCH_TERMS[candidate.to_sym]}&count=#{@batch_qty}&max_id=#{max_id}", headers: {"Authorization" => LesserEvil::APP_AUTH})
		response["statuses"]
	end

	def get_sentiment(text)
		options = { body: { txt: text }}
		response = HTTParty.post(LesserEvil::SENTIMENT_URL, options)
		response["result"]
	end

	def get_print_tweets
	  Whirly.configure spinner: "bouncingBar", remove_after_stop: true, stop: LesserEvil::SEPARATOR
	  Whirly.start 
		max_id = nil
		while @result.length < @tweet_qty
			batch = get_batch(@candidate,@is_intense,max_id)
			max_id = batch.last["id"] - 1
			index = 0
			while index < batch.length && @result.length < @tweet_qty
				status = batch[index]

				# Filter out retweets
				if status["retweeted_status"] == nil || (!@result.collect {|tweet_slim| tweet_slim.orig_id}.include?(status["retweeted_status"]["id"]) && !@result.collect {|tweet_slim| tweet_slim.orig_id}.include?(status["id"]))
					sentiment_analysis = get_sentiment(status["text"])
					intensity = @is_intense ? 1 : 0
					if sentiment_analysis["sentiment"] == @sentiment && sentiment_analysis["confidence"].to_f >= 75 * intensity && @result.length < @tweet_qty
						tweet_slim = TweetSlim.new(@candidate,status)
						Whirly.stop
						tweet_slim.prettyprint if @fast_print
						@result << tweet_slim
						Whirly.start
					end
				end
			  index += 1 
			end
		end
		Whirly.stop
		@result
	end

end
class LesserEvil::TweetController

	attr_accessor :result, :separator_ticker

	LesserEvil::BASE_TWITTER_URL = "https://api.twitter.com/1.1/search/tweets.json"
	LesserEvil::SENTIMENT_URL = "http://sentiment.vivekn.com/api/text/"
	LesserEvil::APP_AUTH = "Bearer AAAAAAAAAAAAAAAAAAAAAPztxgAAAAAAqq0aDjAjGtwkizqhV8wwLdKQB9I%3DY1wGPKUWSz7LV94M2VHBwHle7I3kW46WRmCEgIaZZS6GNTCqwn"
	LesserEvil::SEARCH_TERMS = {
		clinton: "'Hillary+Clinton'+%23ImWithHer+lang:en",
		trump: "'Donald+Trump'+-Jr+%23MAGA+OR+%23MakeAmericaGreatAgain+lang:en"
	}
	LesserEvil::TWEET_QTY = 21
	LesserEvil::BATCH_QTY = 30
	LesserEvil::SEPARATOR = 21

	def initialize
		@result = []
		@separator_ticker = 0
	end

	def get_batch(candidate,is_intense,max_id = nil)
		response = HTTParty.get("#{LesserEvil::BASE_TWITTER_URL}?q=#{LesserEvil::SEARCH_TERMS[candidate.to_sym]}&count=#{LesserEvil::BATCH_QTY}&max_id=#{max_id}", headers: {"Authorization" => LesserEvil::APP_AUTH})
		# binding.pry
		response["statuses"]
	end

	def get_sentiment(text)
		options = { body: { txt: text }}
		response = HTTParty.post(LesserEvil::SENTIMENT_URL, options)
		# binding.pry
		response["result"]
	end

	def print_separator
		if @separator_ticker < LesserEvil::SEPARATOR
			print '-'.red
			@separator_ticker += 1
		end
	end

	def fast_print(tweet_slim)
		(LesserEvil::SEPARATOR - @separator_ticker).times {|i| print '-'.red}
		tweet_slim.prettyprint
		@separator_ticker = 0
	end

	def get_print_tweets(options)
		max_id = nil
		separator_ticker = 0
		while result.length < LesserEvil::TWEET_QTY
			batch = get_batch(options[:candidate],options[:is_intense],max_id)
			max_id = batch.last["id"] - 1
			batch.each do |status|
				# binding.pry # debug
				if !status["retweeted_status"] || !@result.collect {|tweet_slim| tweet_slim.orig_id}.include?(status["retweeted_status"]["id"]) || !@result.collect {|tweet_slim| tweet_slim.orig_id}.include?(status["id"]) 
					print_separator if options[:fast_print]
					# if separator_ticker < LesserEvil::SEPARATOR
					# 	print '-'.red
					# 	separator_ticker += 1
					# end
					sentiment_analysis = get_sentiment(status["text"])
					# puts sentiment_analysis["sentiment"], sentiment_analysis["confidence"] #debug
					if sentiment_analysis["sentiment"] == options[:sentiment] && @result.length < LesserEvil::TWEET_QTY
						tweet_slim = TweetSlim.new(options[:candidate],status)
						fast_print(tweet_slim) if options[:fast_print]
						# binding.pry
						# puts "*** retweeted: #{status[:retweeted_status][:retweeted]}" #debug
						@result << tweet_slim
						# (LesserEvil::SEPARATOR - @separator_ticker).times {|i| print '-'.red}
						# tweet_slim.prettyprint
						# separator_ticker = 0
					end
				else
					# binding.pry # debug
				  puts "*** Found a retweet" # debug
				  puts @result.collect {|t| t.text}
			  end   
			end
			# print "#{result.length}, " #debug
		end
		puts
		@result
	end

end
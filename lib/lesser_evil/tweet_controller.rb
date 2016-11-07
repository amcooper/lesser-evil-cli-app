class LesserEvil::TweetController

	attr_accessor :result, :separator_ticker

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
				if status["retweeted_status"] == nil || (!@result.collect {|tweet_slim| tweet_slim.orig_id}.include?(status["retweeted_status"]["id"]) && !@result.collect {|tweet_slim| tweet_slim.orig_id}.include?(status["id"])) 
					print_separator if options[:fast_print]
					# if separator_ticker < LesserEvil::SEPARATOR
					# 	print '-'.red
					# 	separator_ticker += 1
					# end
					sentiment_analysis = get_sentiment(status["text"])
					# puts sentiment_analysis["sentiment"], sentiment_analysis["confidence"] #debug
					intensity = options[:is_intense] ? 1 : 0
					if sentiment_analysis["sentiment"] == options[:sentiment] && sentinment_analysis["confidence"] >= 75 * intensity && @result.length < LesserEvil::TWEET_QTY
						print "#{status["retweeted_status"] == nil} || ".black.on_yellow
						print "#{!@result.collect {|t| t.orig_id}.include?(status["id"])} && ".black.on_yellow
						print "#{!@result.collect {|t| t.orig_id}.include?(status["retweeted_status"]["id"])} ".black.on_yellow if status["retweeted_status"] != nil
						print sentiment_analysis["confidence"].black.on_yellow
						tweet_slim = TweetSlim.new(options[:candidate],status)
						fast_print(tweet_slim) if options[:fast_print]
						# binding.pry # debug
						# puts "*** retweeted: #{status[:retweeted_status][:retweeted]}" #debug
						@result << tweet_slim
						# (LesserEvil::SEPARATOR - @separator_ticker).times {|i| print '-'.red}
						# tweet_slim.prettyprint
						# separator_ticker = 0
					end
				else
					# binding.pry # debug
				  puts "*** Found a retweet".black.on_yellow # debug
				  # puts @result.collect {|t| t.text}
			  end   
			end
			# print "#{result.length}, " #debug
		end
		puts
		@result
	end

end
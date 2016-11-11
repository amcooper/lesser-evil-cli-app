module LesserEvil

	BASE_TWITTER_URL = "https://api.twitter.com/1.1/search/tweets.json"
  SENTIMENT_URL = "http://sentiment.vivekn.com/api/text/"
	SEARCH_TERMS = {
		clinton: "'Hillary+Clinton'+%23ImWithHer+lang:en",
		trump: "'Donald+Trump'+-Jr+%23MAGA+OR+%23MakeAmericaGreatAgain+lang:en"
	}
	DEFAULT_TWEET_QTY = 9
	DEFAULT_BATCH_QTY = 30
	SEPARATOR = "---------------------\n".red

end

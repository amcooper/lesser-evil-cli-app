# Lesser Evil
**Lesser Evil** is a command line gem that allows the user to view tweets around the recent U.S. presidential election. Lesser Evil presents the user with a choice of candidates (Trump and Clinton) and of sentiments (angry or very angry). It then finds recent tweets about the chosen candidate, filters them through a sentiment analysis engine, and returns the angry or very angry tweets to the screen.

Lesser Evil uses the [Twitter Search API](https://dev.twitter.com/rest/public/search) and [Vivek Narayanan's sentiment analysis tool](http://sentiment.vivekn.com/about/). Mr Narayanan's tool is not perfect. It returns a value of positive, negative, or neutral for each input text, and also a confidence number between 0 and 100. Sometimes, though, you ask for very angry tweets and what you get is not angry at all.

## Installation
Installation is simple. Install the gem on your hard drive

	gem install lesser-evil
and then run it with the following command:

	lesser-evil-cli

## Contributors guide
Go ahead and make a pull request!

## License
[MIT](https://github.com/amcooper/lesser-evil-cli-app/blob/master/LICENSE)
require File.expand_path("../lib/lesser_evil/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'lesser-evil'
  s.version     = LesserEvil::VERSION
  s.executables << 'lesser-evil-cli'
  s.date        = '2016-11-10'
  s.summary     = "Who's the lesser evil in 2016?"
  s.description = "Tweet gathering and sentiment analysis in the 2016 U.S. presidential election"
  s.authors     = ["Adam Cooper"]
  s.email       = 'amcooper@gmail.com'
  s.files       = Dir["{lib}/**/*.rb", "lib/*.rb", "bin/*", "lib/assets/*","Gemfile", "config/*", "LICENSE", "*.md"]
  s.homepage    = 'http://rubygems.org/gems/lesser-evil'
  s.license     = 'MIT'
end
require File.expand_path("../lib/lesser_evil/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'lesser-evil'
  s.version     = LesserEvil::VERSION
  s.executables << 'lesser-evil-cli'
  s.add_runtime_dependency 'httparty', '~> 0.13', '>= 0.13.0'
  s.add_runtime_dependency 'require_all', '~> 1.3', '>= 1.3.3'
  s.add_runtime_dependency 'whirly', '~> 0.2', '>= 0.2.3'
  s.add_runtime_dependency 'paint', '~> 1.0', '>= 1.0.1'
  s.add_runtime_dependency 'colorize', '~> 0.8', '>= 0.8.1'
  s.date        = '2016-11-10'
  s.summary     = "Who's the lesser evil in 2016?"
  s.description = "Tweet gathering and sentiment analysis in the 2016 U.S. presidential election"
  s.authors     = ["Adam Cooper"]
  s.email       = 'amcooper@gmail.com'
  s.files       = Dir["{lib}/**/*.rb", "lib/*.rb", "bin/*", "lib/assets/*","Gemfile", "config/*", "LICENSE", "*.md"]
  s.homepage    = 'http://rubygems.org/gems/lesser-evil'
  s.license     = 'MIT'
end

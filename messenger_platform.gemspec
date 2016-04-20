$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "messenger_platform/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "messenger_platform_rails"
  s.version     = MessengerPlatform::VERSION
  s.authors     = ["FxN"]
  s.email       = ["fxn@fxndev.com"]
  s.homepage    = "https://github.com/efexen/messenger_platform"
  s.summary     = "Ruby on Rails gem for FB Messenger Platform integration"
  s.description = "Ruby on Rails gem for FB Messenger Platform integration"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "httparty", "~> 0.13"

end

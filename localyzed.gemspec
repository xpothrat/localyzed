$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "localyzed/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "localyzed"
  s.version     = Localyzed::VERSION
  s.authors     = ["Nicolas Arbogast"]
  s.email       = ["nicolas.arbogast@gmail.com"]
  s.homepage    = "https://github.com/NicoArbogast/localyzed.git"
  s.summary     = "Simple helper for routes internationalization."
  s.description = %|Includes ActionController helpers implementing unlocalized routes redirection 
                    + a rack_rewrite redirecting /en to /en/ for SEO +
                    the rails-translate-routes gem to be used in target apps|

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency 'rack-rewrite', '~> 1.2.1'
  s.add_dependency "rails-translate-routes"

  s.add_development_dependency "sqlite3"
end

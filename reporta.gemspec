$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reporta/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reporta"
  s.version     = Reporta::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Reporta."
  s.description = "TODO: Description of Reporta."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "debugger"
end

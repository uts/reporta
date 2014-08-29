$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reporta/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reporta-modules"
  s.version     = Reporta::VERSION
  s.authors     = ["Scott Harvey", "Garrett Heinlen", "Elle Meredith", "Tim McEwan", "Alvin S.J. Ng"]
  s.email       = ["email.to.alvin@gmail.com"]
  s.homepage    = "http://www.github.com/alvinsj/reporta-modules"
  s.summary     = "A rubygem packed with modules to help you build your reports."
  s.description = "A rubygem packed with modules to help you build your reports."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">=3.2.0", "<5"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "debugger"
  
  s.license = 'MIT'
  s.require_path = 'lib'
end

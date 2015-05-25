# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "solidus_gateway"
  s.version     = "1.0.0"
  s.summary     = "Additional Payment Gateways for Solidus"
  s.description = s.summary
  s.required_ruby_version = ">= 2.1"

  s.author       = "Solidus Team"
  s.email        = "contact@solidus.io"
  s.homepage     = "https://solidus.io"
  s.license      = %q{BSD-3}

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = "lib"
  s.requirements << "none"

  s.add_dependency "solidus_core", [">= 1.0.0.pre", "< 2"]

  s.add_development_dependency "braintree"
  s.add_development_dependency "rspec-rails", "~> 2.99"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "sass-rails", "~> 4.0.0"
  s.add_development_dependency "coffee-rails", "~> 4.0.0"
  s.add_development_dependency "factory_girl", "~> 4.4"
  s.add_development_dependency "rspec-activemodel-mocks"
  s.add_development_dependency "capybara"
  s.add_development_dependency "poltergeist", "~> 1.5.0"
  s.add_development_dependency "database_cleaner", "1.2.0"
end

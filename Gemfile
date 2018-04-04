source "https://rubygems.org"

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem "solidus", github: "solidusio/solidus", branch: branch

if branch == 'master' || branch >= "v2.0"
  gem "rails-controller-testing", group: :test
end

# hacks to speed up bundler resolution
if branch == 'master' || branch >= "v2.3"
  gem 'rails', '~> 5.1.6'
elsif branch >= "v2.0"
  gem 'rails', '~> 5.0.7'
else
  gem "rails", "~> 4.2.10"
end

gem 'pg', '~> 0.21'
gem 'mysql2', '~> 0.4.10'

gem 'chromedriver-helper' if ENV['CI']

group :development, :test do
  gem "pry-rails"
  gem "ffaker"
end

gemspec

require "simplecov"
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require "rspec/rails"

require "capybara/rspec"
require "capybara-screenshot/rspec"
require "capybara/poltergeist"
Capybara.register_driver(:poltergeist) do |app|
  Capybara::Poltergeist::Driver.new app, timeout: 90
end
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 10

require "database_cleaner"
require "braintree"
require "ffaker"

require "spree/testing_support/authorization_helpers"
require "spree/testing_support/factories"
require "spree/testing_support/order_walkthrough"
require "spree/testing_support/capybara_ext"

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.mock_with :rspec

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = false

  config.include FactoryGirl::Syntax::Methods

  config.before :suite do
    DatabaseCleaner.clean_with :truncation

    # Don't log Braintree to STDOUT.
    Braintree::Configuration.logger = Logger.new("spec/dummy/tmp/log")
  end

  config.before do
    DatabaseCleaner.strategy = RSpec.current_example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
    Spree::Config.set(auto_capture: false)
  end

  config.after do
    DatabaseCleaner.clean
  end

  FactoryGirl.find_definitions
end

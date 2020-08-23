# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  VCR.configure do |config|
    config.cassette_library_dir = Rails.root.join "test", "vcr_cassettes"
    config.hook_into :webmock
    config.ignore_localhost = true
    config.ignore_hosts "chromedriver.storage.googleapis.com"
    config.allow_http_connections_when_no_cassette = false
    config.filter_sensitive_data("{key}") { ENV["GOOGLE_API_KEY"] }
    config.filter_sensitive_data("{cse}") { ENV["GOOGLE_CSE_ID"] }
  end
end

# frozen_string_literal: true

require "test_helper"

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join "test", "vcr_cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = false
  config.filter_sensitive_data("{key}") { ENV.fetch("GOOGLE_API_KEY") }
  config.filter_sensitive_data("{cse}") { ENV.fetch("GOOGLE_CSE_ID") }
end

class KeywordTest < ActiveSupport::TestCase
  def setup
    VCR.use_cassette("google_mock") do
      @before_create_rank = Ranking.count
      Keyword.find_by(keyword: "Ruby スクール").create_rank
    end
  end

  test "#create_rank" do
    assert_not_equal @before_create_rank, Ranking.count
  end
end

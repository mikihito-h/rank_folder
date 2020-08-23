# frozen_string_literal: true

require "test_helper"

class KeywordTest < ActiveSupport::TestCase
  test "#create_rank" do
    @before_create_rank = Ranking.count
    VCR.use_cassette("google_mock") do
      Keyword.find_by(keyword: "Ruby スクール").create_rank
    end
    assert_not_equal @before_create_rank, Ranking.count
  end
end

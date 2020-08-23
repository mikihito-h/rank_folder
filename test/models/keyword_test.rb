# frozen_string_literal: true

require "test_helper"

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

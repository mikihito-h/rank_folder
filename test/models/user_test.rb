# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "::guest" do
    assert_equal User.guest.email, "guest@example.com"
  end
end

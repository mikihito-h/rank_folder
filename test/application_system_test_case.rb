# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["HEADED"]
    driven_by :selenium, using: :chrome
  else
    driven_by :selenium, using: :headless_chrome
  end

  include Devise::Test::IntegrationHelpers
end

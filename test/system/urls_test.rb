# frozen_string_literal: true

require "application_system_test_case"

class UrlsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_1)
    login_as(@user)
  end

  # test "url一覧を表示する" do
  #   visit urls_path
  #   assert_selector "h1", text: "Urls"
  # end

  # test "urlを新規登録する" do
  #   visit urls_path
  #   click_on "New Url"

  #   fill_in "Url", with: "https://example.com"
  #   click_on "検索ワードを追加"
  #   fill_in "Keyword", with: "ruby スクール"
  #   click_on "検索ワードを追加"
  #   click_on "登録する"

  #   assert_text "Urlを登録しました。"
  # end

  # test "urlの詳細画面を表示する" do
  #   visit urls_path
  #   click_on "Show", match: :first
  #   assert_selector "h1", text: "URL詳細"
  # end

  # test "urlを削除" do
  #   visit urls_path
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end
  #   assert_text "Urlを削除しました。"

  #   visit urls_path
  #   click_on "Show", match: :first
  #   page.accept_confirm do
  #     click_link "btn-destroy-url"
  #   end
  #   assert_text "Urlを削除しました。"
  # end
end

# frozen_string_literal: true

require "application_system_test_case"

class UrlsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_1)
    login_as @user
  end

  test "URL一覧を表示する" do
    visit urls_path
    assert_selector "h2", text: "URL一覧"
  end

  test "URLを新規登録する" do
    visit urls_path
    click_on "URL追加"

    fill_in "Url", with: "https://example.com"
    click_on "検索ワードを追加"
    fill_in "Keyword", with: "ruby スクール"
    click_on "検索ワードを追加"
    click_on "登録する"

    assert_text "Urlを登録しました。"
  end

  test "URL詳細画面を表示する" do
    visit urls_path
    click_on "詳細", match: :first
    assert_selector "h2", text: "URL詳細"
  end

  test "URLを削除" do
    visit urls_path
    click_on "詳細", match: :first

    assert_difference "Url.count", -1 do
      page.accept_confirm do
        click_on "URL削除"
      end
      assert_text "Urlを削除しました。"
    end
  end

  test "検索ワードを削除" do
    visit urls_path
    click_on "詳細", match: :first

    assert_difference "Keyword.count", -1 do
      page.accept_confirm do
        click_on "削除", match: :first
      end
      assert_text "」を削除しました。"
    end
  end

  test "検索ワードを追加" do
    visit urls_path
    click_on "詳細", match: :first
    click_on "検索ワード追加"

    assert_difference "Keyword.count", 1 do
      fill_in "Keyword", with: "表参道 ランチ"
      click_on "追加する"
      assert_text "検索ワード「表参道 ランチ」を登録しました。"
    end
  end
end

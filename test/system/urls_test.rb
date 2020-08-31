# frozen_string_literal: true

require "application_system_test_case"

class UrlsTest < ApplicationSystemTestCase
  test "URL一覧を表示する" do
    login_as users(:user_1)
    visit urls_path
    assert_selector "h2", text: "サイト一覧"
  end

  test "URLを新規登録する" do
    login_as users(:user_3)
    visit urls_path
    click_on "サイトを追加"

    fill_in "サイトURL", with: "https://example.com"
    click_on "検索ワードを追加"
    fill_in "検索ワード", with: "ruby スクール"
    click_on "検索ワードを追加"
    click_on "登録する"

    assert_text "Urlを登録しました。"
  end

  test "URL詳細画面を表示する" do
    login_as users(:user_1)
    visit urls_path
    click_on "順位を見る", match: :first
    assert_selector "h2", text: "サイトURL"
  end

  test "URLを削除" do
    login_as users(:user_1)
    visit urls_path
    click_on "順位を見る", match: :first

    assert_difference "Url.count", -1 do
      page.accept_confirm do
        click_on "URLを削除"
      end
      assert_text "Urlを削除しました。"
    end
  end

  test "検索ワードを削除" do
    login_as users(:user_1)
    visit urls_path
    click_on "順位を見る", match: :first

    assert_difference "Keyword.count", -1 do
      page.accept_confirm do
        click_on "削除", match: :first
      end
      assert_text "」を削除しました。"
    end
  end

  test "検索ワードを追加" do
    login_as users(:user_3)
    visit urls_path
    click_on "順位を見る", match: :first
    click_on "検索ワードを追加"

    assert_difference "Keyword.count", 1 do
      fill_in "検索ワード", with: "表参道 ランチ"
      click_on "追加する"
      assert_text "検索ワード「表参道 ランチ」を登録しました。"
    end
  end

  test "APIのレスポンスを確認" do
    visit "api/v1/ranks.json?api_key=user1apikey"
    assert_text '{"https://example.com":{"Ruby スクール":{"2020-08-13":5,"2020-08-12":3,"2020-08-11":4,"2020-08-10":8,"2020-08-09":5,"2020-08-08":5},"プログラミング":{"2020-08-13":1,"2020-08-12":3,"2020-08-11":2,"2020-08-10":3,"2020-08-09":5,"2020-08-08":20}}}'
  end
end

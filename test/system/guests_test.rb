# frozen_string_literal: true

require "application_system_test_case"

class GuestsTest < ApplicationSystemTestCase
  setup do
    login_as users(:guest_user)
  end

  test "ゲストユーザーはURLの登録ができない" do
    visit urls_path
    click_on "URL追加"

    assert_no_difference "Url.count" do
      fill_in "URL", with: "https://example.com"
      click_on "検索ワードを追加"
      fill_in "検索ワード", with: "ruby スクール"
      click_on "検索ワードを追加"
      click_on "登録する"
      assert_text "かんたんログイン中にその操作はできません。"
    end
  end

  test "ゲストユーザーはURLの削除ができない" do
    visit urls_path
    click_on "詳細", match: :first

    assert_no_difference "Url.count" do
      page.accept_confirm do
        click_on "URL削除"
      end
      assert_text "かんたんログイン中にその操作はできません。"
    end
  end

  test "ゲストユーザーは検索ワードの追加ができない" do
    visit urls_path
    click_on "詳細", match: :first
    click_on "検索ワード追加"

    assert_no_difference "Keyword.count" do
      fill_in "検索ワード", with: "表参道 ランチ"
      click_on "追加する"
      assert_text "かんたんログイン中にその操作はできません。"
    end
  end

  test "ゲストユーザーは検索ワードを削除できない" do
    visit urls_path
    click_on "詳細", match: :first

    assert_no_difference "Keyword.count" do
      page.accept_confirm do
        click_on "削除", match: :first
      end
      assert_text "かんたんログイン中にその操作はできません。"
    end
  end

  test "ゲストユーザーは登録情報変更ページに行けない" do
    visit edit_user_registration_path
    assert_text "かんたんログイン中にその操作はできません。"
  end
end

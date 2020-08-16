# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_1)
    login_as @user
  end

  test "登録情報変更" do
    visit edit_user_registration_path
    assert_selector "h2", text: "登録情報変更"
    fill_in "Eメール", with: "user4@example.com"
    fill_in "現在のパスワード", with: "password"
    click_on "更新"
    assert_text "アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。"
    visit edit_user_registration_path
    assert_text "user4@example.com の確認待ち"
  end

  test "アカウントを削除する" do
    visit edit_user_registration_path
    assert_difference "User.count", -1 do
      page.accept_confirm do
        click_on "アカウント削除"
      end
      assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
    end
  end

  test "ログアウトする" do
    visit urls_path
    click_on "Menu"
    click_on "ログアウト"
    assert_text "ログアウトしました。"
  end

  test "APIキーを確認する" do
    visit api_reference_path
    assert_text "あなたのAPIキーは user1apikey です。"
  end

  test "ログインしていない時はAPIキーが表示されない" do
    logout
    visit api_reference_path
    assert_no_text "あなたのAPIキーは"
  end
end

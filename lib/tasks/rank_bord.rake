# frozen_string_literal: true

desc "ゲストユーザーのURL、検索ワード、ランキングデータを全て削除"
task delete_guest_data: :environment do
  User.find_by(email: "guest@example.com")&.urls&.destroy_all
end

desc "Google検索順位を保存"
task create_rank: :environment do
  Keyword.create_rank
end

desc "ゲストユーザーのURL、検索ワード、ランキングデータを生成"
task create_guest_data: :environment do
  guest_user = User.guest
  ActiveRecord::Base.transaction do
    8.times do |n|
      url = guest_user.urls.create(url: "https://example.com/#{n+1}")
      url.keywords.create(keyword: "東京 ご飯")
      url.keywords.create(keyword: "日本 観光 おすすめ")
      url.keywords.create(keyword: "渋谷 ランチ")
      url.keywords.create(keyword: "ランチ おすすめ")
      url.keywords.create(keyword: "ランチ 人気店")
      url.keywords.each do |keyword|
        8.times do |v|
          keyword.rankings.create(rank: rand(1..10), acquired_on: "2020-10-0#{v+1}")
        end
      end
    end
  end
end

# ゲストユーザーの検索ワードの順位を取得しない為に、create_rankタスクの前にゲストユーザーのデータを一度削除する。
task routene: [:delete_guest_data, :create_rank, :create_guest_data]

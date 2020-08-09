# frozen_string_literal: true

desc "Google検索順位を保存"
task create_rank: :environment do
  Keyword.all.each do |k|
    begin
      urls =  GoogleSearch.new.urls(k.keyword)
    rescue => e
      puts "エラークラス: #{e.class}"
      puts "エラーメッセージ: #{e.message}"
      puts "バックトレース ------------"
      puts e.backtrace
      puts "---------------------------"

      urls = []
    end

    if urls.present?
      rank = RankChecker.new.find_rank(urls, k.url.url)
    else
      rank = 0
    end

    Ranking.create(rank: rank, keyword_id: k.id)
  end
end

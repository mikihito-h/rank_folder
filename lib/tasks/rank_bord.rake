# frozen_string_literal: true

desc "Google検索順位を保存"
task create_rank: :environment do
  Keyword.all.each do |k|
    begin
      url_array =  GoogleSearch.new.urls(k.keyword)
    rescue => e
      puts "エラークラス: #{e.class}"
      puts "エラーメッセージ: #{e.message}"
      puts "バックトレース ------------"
      puts e.backtrace
      puts "---------------------------"

      url_array = []
    end

    unless url_array.empty?
      rank = RankChecker.new.find(url_array, k.url.url)
    else
      rank = 0
    end

    Ranking.create(rank: rank, keyword_id: k.id)
  end
end

# frozen_string_literal: true

desc "Google検索順位を保存"
task create_rank: :environment do
  Keyword.all.each do |k|
    begin
      urls =  GoogleSearch.new.fetch_urls(k.keyword)
    rescue => e
      puts e.full_message
      Rails.logger.error e.full_message

      urls = []
    end

    if urls.present?
      rank = RankChecker.new.find_rank(urls, k.url.url)
    else
      rank = 0
    end

    k.rankings.create!(rank: rank)
  end
end

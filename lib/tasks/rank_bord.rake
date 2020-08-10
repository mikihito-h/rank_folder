# frozen_string_literal: true

desc "Google検索順位を保存"
task create_rank: :environment do
  Keyword.all.each do |keyword|
    begin
      urls =  GoogleSearch.new.fetch_urls(keyword.keyword)
    rescue => e
      puts e.full_message
      Rails.logger.error e.full_message

      urls = []
    end

    if urls.present?
      rank = GoogleSearch.new.find_rank(urls, keyword.url.url)
    else
      rank = 0
    end

    keyword.rankings.create!(rank: rank)
  end
end

# frozen_string_literal: true

class Keyword < ApplicationRecord
  belongs_to :url
  has_many :rankings, dependent: :destroy
  validates :keyword, presence: true

  class << self
    def create_rank
      all.each do |keyword|
        keyword.create_rank
      rescue => e
        Rails.logger.error e.full_message
      end
    end
  end

  def create_rank
    urls = fetch_urls
    rank = urls.present? ? get_rank(urls, self.url.url) : 0
    ranking = self.rankings.find_or_initialize_by(acquired_on: Date.current)
    ranking.rank = rank
    ranking.save!
  end

  private
    def fetch_urls
      start_index = 1
      max_start_index = 91
      urls = []
      begin
        response = request_to_google(start_index)
        if response.code != "200"
          Rails.logger.error "Google Custom Search APIのレスポンスがエラーでした。\nレスポンスコード: #{response.code}\nレスポンスボディー: #{response.body}"
          break
        end
        json_response_body = JSON.parse(response.body)
        break if (extracted_urls = extract_urls(json_response_body)) == []
        urls += extracted_urls
      end while (start_index = json_response_body.dig("queries", "nextPage", 0, "startIndex")) && start_index <= max_start_index
      urls
    end

    def get_rank(urls, registered_url)
      index = urls.index { |url| url == registered_url || url == registered_url + "/" }
      index ? index + 1 : 0
    end

    def request_to_google(start_index)
      query = URI.encode_www_form(key: ENV["GOOGLE_API_KEY"], cx: ENV["GOOGLE_CSE_ID"], q: self.keyword, safe: "off", num: 10, start: start_index)
      built_url = URI::HTTPS.build(host: "www.googleapis.com", path: "/customsearch/v1", query: query)
      Net::HTTP.get_response(built_url)
    end

    def extract_urls(json_data)
      Array(json_data["items"]).map do |item|
        item["link"]
      end
    end
end

# frozen_string_literal: true

class Keyword < ApplicationRecord
  belongs_to :url
  validates :keyword, presence: true
  has_many :rankings, dependent: :destroy


  def self.create_rank
    Keyword.all.each do |keyword|
      keyword.create_rank
    rescue => e
      puts e.full_message
      Rails.logger.error e.full_message
      next
    end
  end

  def create_rank
    urls =  fetch_urls(self.keyword)

    if urls.present?
      rank = get_rank(urls, self.url.url)
    else
      rank = 0
    end

    if rank_of_the_same_date = self.rankings.find_by(rank_acquisition_date: Date.current)
      rank_of_the_same_date.update!(rank: rank)
    else
      self.rankings.create!(rank: rank, rank_acquisition_date: Date.current)
    end
  end


  private
    def fetch_urls(keyword)
      response = request_to_google(keyword)
      if response.code == "200"
        json_response_body = JSON.parse(response.body)
        urls = extract_urls(json_response_body)
      else
        urls = []
      end
      if response.code == "200" && json_response_body["queries"]["nextPage"]
        urls = get_100_urls(json_response_body, urls, keyword)
      end
      urls
    end

    def get_rank(urls, registered_url)
      index = urls.index { |url| url == registered_url || url == registered_url + "/" }
      if index
        return index + 1
      end
      0
    end

    def request_to_google(keyword, start_index = 1)
      query = URI.encode_www_form([["key", ENV["GOOGLE_API_KEY"]], ["cx", ENV["GOOGLE_CSE_ID"]], ["q", keyword], ["safe", "off"], ["num", 10], ["start", start_index]])
      built_url = URI::HTTPS.build({ host: "www.googleapis.com", path: "/customsearch/v1", query: query })
      Net::HTTP.get_response(built_url)
    end

    def extract_urls(json_data)
      if json_data["items"]
        json_data["items"].map do |item|
          item["link"]
        end
      else
        []
      end
    end

    def get_100_urls(json_response_body, urls, keyword)
      while (start_index = json_response_body.dig("queries", "nextPage", 0, "startIndex")) && start_index <= 91
        response = request_to_google(keyword, start_index)
        break unless response.code == "200"
        json_response_body = JSON.parse(response.body)
        urls += extract_urls(json_response_body)
      end
      urls
    end
end

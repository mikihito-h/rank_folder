# frozen_string_literal: true

require "net/http"
require "json"

class GoogleSearch
  def initialize
    @api_key = ENV["GOOGLE_API_KEY"]
    @cse_id = ENV["GOOGLE_CSE_ID"]
  end

  def fetch_urls(keyword)
    response = request_to_google(keyword)
    if response.code == "200"
      json_response_body = JSON.parse(response.body)
      urls = extract_urls(json_response_body)
    else
      urls = []
    end
    if response.code == "200" && json_response_body["queries"]["nextPage"]
      get_100_urls(json_response_body, urls, keyword)
    end
    urls
  end

  private
    def request_to_google(keyword, start_index = 1)
      query = URI.encode_www_form([["key", @api_key], ["cx", @cse_id], ["q", keyword], ["safe", "off"], ["num", 10], ["start", start_index]])
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
      while (start_index = json_response_body.dig(:queries, :nextPage, 0, :startIndex)) && start_index <= 91
        response = request_to_google(keyword, start_index)
        break unless response.code == "200"
        json_response_body = JSON.parse(response.body)
        urls += extract_urls(json_response_body)
      end
    end
end

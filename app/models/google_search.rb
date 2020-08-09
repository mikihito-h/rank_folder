# frozen_string_literal: true

require "net/http"
require "json"

class GoogleSearch
  def initialize
    @api_key = ENV["GOOGLE_API_KEY"]
    @cse_id = ENV["GOOGLE_CSE_ID"]
  end

  def urls(keyword)
    start_index = 1
    response = request_to_google(start_index, keyword)
    json_response_body = make_json(response.body)
    urls = extract_url(json_response_body)
    if response.code == "200" && json_response_body["queries"]["nextPage"]
      get_100_urls(json_response_body, urls, encoded_keyword)
    end
    urls
  end

  private
    def request_to_google(start_index, keyword)
      parameters = URI.encode_www_form([["key", @api_key], ["cx", @cse_id], ["q", keyword], ["safe", "off"], ["num", 10], ["start", start_index]])
      Net::HTTP.get_response(URI.parse("https://www.googleapis.com/customsearch/v1?#{parameters}"))
    end

    def make_json(data)
      JSON.parse(data)
    end

    def extract_url(json_data)
      if json_data["items"]
        json_data["items"].map do |item|
          item["link"]
        end
      else
        []
      end
    end

    def get_100_urls(json_response_body, urls, encoded_keyword)
      while json_response_body["queries"]["nextPage"][0]["startIndex"] <= 91
        start_index = json_response_body["queries"]["nextPage"][0]["startIndex"]
        response = request_to_google(start_index, encoded_keyword)
        break unless response.code == "200"
        json_response_body = make_json(response.body)
        urls << extract_url(json_response_body)
        urls.flatten!
        break unless json_response_body["queries"]["nextPage"]
      end
    end
end

# frozen_string_literal: true

require "net/http"
require "json"

class GoogleSearch
  def initialize
    @api_key = ENV["GOOGLE_API_KEY"]
    @cse_id = ENV["GOOGLE_CSE_ID"]
  end

  def urls(keyword)
    encoded_keyword = URI.encode_www_form(q: keyword)
    start_index = 1
    response = google_it(start_index, encoded_keyword)
    json_response_body = make_json(response.body)
    urls = extract_url(json_response_body)
    if response.code == "200" && json_response_body["queries"]["nextPage"]
      get_100_urls(json_response_body, urls, encoded_keyword)
    end
    urls
  end

  private
    def google_it(start, encoded_keyword)
      Net::HTTP.get_response(URI.parse("https://www.googleapis.com/customsearch/v1?key=#{@api_key}&cx=#{@cse_id}&#{encoded_keyword}&safe=off&num=10&start=#{start}"))
    end

    def make_json(response_body)
      JSON.parse(response_body)
    end

    def extract_url(json_response_body)
      if json_response_body["items"]
        json_response_body["items"].map do |item|
          item["link"]
        end
      else
        []
      end
    end

    def get_100_urls(json_response_body, urls, encoded_keyword)
      while json_response_body["queries"]["nextPage"][0]["startIndex"] <= 91
        start_index = json_response_body["queries"]["nextPage"][0]["startIndex"]
        response = google_it(start_index, encoded_keyword)
        break unless response.code == "200"
        json_response_body = make_json(response.body)
        urls << extract_url(json_response_body)
        urls.flatten!
        break unless json_response_body["queries"]["nextPage"]
      end
    end
end

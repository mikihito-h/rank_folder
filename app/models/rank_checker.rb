# frozen_string_literal: true

class RankChecker
  def find_rank(urls, registered_url)
    urls.each.with_index(1) do |url, index|
      if url == registered_url || url == registered_url + "/"
        return index
      end
    end
    0
  end
end

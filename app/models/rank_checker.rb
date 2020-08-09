# frozen_string_literal: true

class RankChecker
  def find_rank(urls, registered_url)
    index = urls.index { |url| url == registered_url || url == registered_url + "/" }
    if index
      return index + 1
    end
    0
  end
end

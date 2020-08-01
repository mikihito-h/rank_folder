# frozen_string_literal: true

class RankChecker
  def find(url_array, registered_url)
    url_array.each.with_index(1) do |url, index|
      if url == registered_url || url == registered_url + "/"
        return index
      end
    end
    # 100位圏外のときは順位を0にする
    0
  end
end

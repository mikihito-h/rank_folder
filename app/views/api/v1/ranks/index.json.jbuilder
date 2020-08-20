# frozen_string_literal: true

@urls.each do |url|
  json.set! url.url do
    url.keywords.each do |k|
      json.set! k.keyword do
        k.rankings.each do |r|
          json.set! r.acquired_on, r.rank
        end
      end
    end
  end
end

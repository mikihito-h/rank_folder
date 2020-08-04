# frozen_string_literal: true

@urls.each do |url|
  json.set! url.url do
    url.keywords.each do |k|
      json.set! k.keyword do
        k.rankings.each do |r|
          json.set! l(r.created_at, format: :short), r.rank
        end
      end
    end
  end
end

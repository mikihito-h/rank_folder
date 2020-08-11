# frozen_string_literal: true

desc "Google検索順位を保存"
task create_rank: :environment do
  Keyword.create_rank
end

# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.7.1"

gem "rails", "6.0.3.2"
gem "pg"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false

# not default
gem "devise"
gem "devise-i18n"
gem "slim-rails"
gem "cocoon"
gem "chartkick"
gem "bootstrap", "~> 4.5.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # not default
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "html2slim"
  gem "letter_opener_web"
  gem "i18n_generators"
  gem "hanmoto"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "vcr"
  gem "webmock"
end

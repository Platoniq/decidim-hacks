# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION
DECIDIM_VERSION = { git: "https://github.com/decidim/decidim", branch: "0.18-stable" }

gem "decidim", DECIDIM_VERSION
# gem "decidim-consultations", DECIDIM_VERSION
# gem "decidim-initiatives", DECIDIM_VERSION
gem "redcarpet"

gem "bootsnap", "~> 1.3"

gem "puma", "~> 3.0"
gem "uglifier", "~> 4.1"
gem "sprockets", "~> 3.7.2" # sprockets 4.0 brokes decidim

gem "faker", "~> 1.9"

group :development, :test do
  gem "byebug", "~> 10.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

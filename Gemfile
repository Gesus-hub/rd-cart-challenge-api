# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.1"
gem "bootsnap", require: false
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "strong_migrations", "~> 2.0.0"
gem "tzinfo-data", platforms: %i[windows jruby]

gem "redis", "~> 5.2"
gem "sidekiq", "~> 7.2", ">= 7.2.4"
gem "sidekiq-cron"
gem "sidekiq-scheduler", "~> 5.0", ">= 5.0.3"

gem "rswag-api",   "~> 2.15.0"
gem "rswag-ui",    "~> 2.15.0"

gem "discard", "~> 1.4.0"
gem "guard"
gem "guard-livereload", require: false

group :development, :test do
  gem "database_cleaner", "~> 2.1.0"
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails", "~> 6.4.3"
  gem "faker", "~> 3.4.2"
  gem "pry-byebug", "~> 3.10"
  gem "pry-rails", "~> 0.3.11"
  gem "rspec-rails", "~> 6.1.0"
  gem "rswag-specs", "~> 2.16.0"
end

group :test do
  gem "shoulda-matchers", "~> 6.4.0", require: false
end

group :development do
  gem "rubocop", "~> 1.68.0", require: false
  gem "rubocop-factory_bot", "~> 2.26.1", require: false
  gem "rubocop-performance", "~> 1.22.1", require: false
  gem "rubocop-rails", "~> 2.27.0", require: false
  gem "rubocop-rspec", "~> 3.2.0", require: false
  gem "rubocop-rspec_rails", "~> 2.30.0", require: false
  gem "spring", "~> 4.2.1"
  gem "spring-commands-rspec"
end

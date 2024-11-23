# frozen_string_literal: true

Sidekiq.configure_client do |config|
  config.redis = {
    url: (ENV["REDIS_URL"] || "redis://localhost:6379/0"),
    db: 1
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    url: (ENV["REDIS_URL"] || "redis://localhost:6379/0"),
    db: 1
  }
end

# Perform Sidekiq jobs immediately in prod, staging, develop or test (inline)
#
if Rails.env.production? || Rails.env.staging?
  Rails.logger.info "Redis is available, using Sidekiq for ActiveJob"
else
  Rails.logger.warn "Using inline ActiveJob adapter"
end

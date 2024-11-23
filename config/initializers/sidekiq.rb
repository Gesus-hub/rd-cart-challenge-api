# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-cron'

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

  schedule_file = Rails.root.join('config', 'sidekiq.yml')

  if File.exist?(schedule_file)
    yaml = YAML.load_file(schedule_file).deep_symbolize_keys
    if yaml[:cron]
      Sidekiq::Cron::Job.load_from_hash(yaml[:cron])
    end
  end
end

if Rails.env.production? || Rails.env.staging?
  Rails.logger.info "Redis is available, using Sidekiq for ActiveJob"
else
  Rails.logger.warn "Using inline ActiveJob adapter"
  Rails.application.config.active_job.queue_adapter = :inline
end

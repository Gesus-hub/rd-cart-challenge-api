require "sidekiq"
require "sidekiq-scheduler"

if Sidekiq.server? && !Rails.env.test?
  Sidekiq.configure_server do |config|
    config.on(:startup) do
      Sidekiq.schedule = YAML.load_file(File.expand_path("../../sidekiq_scheduler.yml", __FILE__))
      SidekiqScheduler::Scheduler.instance.reload_schedule!
    end
  end
else
  SidekiqScheduler::Scheduler.instance.enabled = false
  puts "SidekiqScheduler::Scheduler.instance.enabled is #{SidekiqScheduler::Scheduler.instance.enabled.inspect}"
end

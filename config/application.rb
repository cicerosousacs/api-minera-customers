require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiMineraCustomers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'America/Fortaleza'
    config.active_record.default_timezone = :utc
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.active_job.queue_adapter = :resque

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :user_name => '0e76b1cc23fd98',
      :password => 'd9244d12987d23',
      :address => 'sandbox.smtp.mailtrap.io',
      :host => 'sandbox.smtp.mailtrap.io',
      :port => '2525',
      :authentication => :login,
      :openssl_verify_mode => OpenSSL::SSL::VERIFY_NONE
    }
  end
end

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require *Rails.groups(:assets) if defined?(Bundler)

module PixieStrd6Com
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{config.root}/extras )
    # Add additional load paths for your own custom dirs
    %w[middleware].each do |dir|
      config.autoload_paths << "#{config.root}/app/#{dir}"
    end

    config.autoload_paths << File.join(config.root, "lib")

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.middleware.use ExceptionNotifier,
      :email_prefix => "[pixie.strd6.com] ",
      :sender_address => %{"Notifier" <notifier@strd6.com>},
      :exception_recipients => %w[yahivin@gmail.com mdiebolt@gmail.com]

    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.assets          false
      g.helper          false
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :test_unit, :fixture => false
    end

    config.assets.enabled = true
    config.assets.initialize_on_precompile = false
    config.generators.stylesheet_engine = :sass

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end

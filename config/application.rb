# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GeolocationApi
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = 'Central Time (US & Canada)'
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.api_only = true
    config.autoload_paths += %W[#{config.root}/app/services #{config.root}/app/errors]
    config.autoload_paths += %W[#{config.root}/app/repositories]
    config.autoload_paths += %W[#{config.root}/app/lib/ipstack]
  end
end

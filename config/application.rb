require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module RenatArslanov
  class Application < Rails::Application
    config.load_defaults 8.1

    config.autoload_lib(ignore: %w[assets tasks])

    # Russian locale as default
    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]

    # Time zone
    config.time_zone = "Moscow"
  end
end

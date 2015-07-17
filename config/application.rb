require File.expand_path('../boot', __FILE__)

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Linkus
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.default_locale = :ja

    config.generators.template_engine = :slim
    config.generators.helper          = false
    config.generators.assets          = false

    config.autoload_paths += %W(#{config.root}/lib)

    config.active_record.raise_in_transactional_callbacks = true

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api')]
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
  end
end

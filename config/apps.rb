# frozen_string_literal: true

require 'i18n'
require 'i18n/backend/fallbacks'
##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, 'f788e216aaceb8bfac32facc376f4f3a8e4f08ed7c768cd7fa01a355a505dc2d'
  set :protection, except: :path_traversal
  set :protect_from_csrf, false

  use Rack::Cors do
    allow do
      # put real origins here
      origins '*'
      # and configure real resources here
      resource '*', headers: :any, methods: %i[get post options put]
    end
  end

  configure do
    I18n::Backend::Simple.include I18n::Backend::Fallbacks
    I18n.load_path += Dir[File.join(settings.root, 'locales', '*.yml')]
    I18n.backend.load_translations
  end

  use Rack::Locale
end

# Mounts the core application for this project
Padrino.mount('GitClassRoomService::App', app_file: Padrino.root('app/app.rb')).to('/')

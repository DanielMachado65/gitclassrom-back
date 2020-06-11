# frozen_string_literal: true

source 'https://rubygems.org'

# Padrino supports Ruby version 2.2.2 and later
# ruby '2.3.7'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# tada Makes http fun again!
gem 'httparty'

# Project requirements
gem 'rack-cors'
gem 'rake'

# Component requirements
gem 'mongoid', '>= 7.1.2'

gem 'prometheus-client'

# Padrino Stable Gem
gem 'padrino', '0.14.4'

gem 'thin'

gem 'sentry-raven'

group :development do
  gem 'pry'
end

group :test do
  gem 'byebug'
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'faker'
  gem 'rack-test'
  gem 'rspec'
end

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.14.4'
# end

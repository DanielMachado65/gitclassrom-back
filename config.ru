#!/usr/bin/env rackup
# frozen_string_literal: true

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path('config/boot.rb', __dir__)
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'
require 'raven'

Raven.configure do |config|
  config.environments = %w[staging production master]
  config.current_environment = ENV['SENTRY_CURRENT_ENV']
  config.release = ENV['VERSION']
end

use Raven::Rack
use Prometheus::Middleware::Collector

run Padrino.application

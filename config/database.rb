# frozen_string_literal: true

# Connection.new takes host and port.

host = 'gitclassroom-mongo'
port = 27_017

database_name = case Padrino.env
                when :development then 'gitclassroom_service_development'
                when :production  then 'gitclassroom_service_production'
                when :test        then 'gitclassroom_service_test'
                end

# Use MONGO_URI if it's set as an environmental variable.
database_settings = if ENV['MONGO_URI']
                      { default: { uri: ENV['MONGO_URI'] } }
                    else
                      { default: { hosts: ["#{host}:#{port}"], database: database_name } }
                    end

Mongoid.raise_not_found_error = false

case Mongoid::VERSION
when /^(3|4)/
  Mongoid::Config.sessions = database_settings
else
  Mongoid::Config.load_configuration clients: database_settings
end

# If you want to use a YML file for config, use this instead:
#
#   Mongoid.load!(File.join(Padrino.root, 'config', 'database.yml'), Padrino.env)
#
# And add a config/database.yml file like this:
#   development:
#     clients: #Replace clients with sessions to work with Mongoid version 3.x or 4.x
#       default:
#         database: product_service_development
#         hosts:
#           - localhost:27017
#
#   production:
#     clients: #Replace clients with sessions to work with Mongoid version 3.x or 4.x
#       default:
#         database: product_service_production
#         hosts:
#           - localhost:27017
#
#   test:
#     clients: #Replace clients with sessions to work with Mongoid version 3.x or 4.x
#       default:
#         database: product_service_test
#         hosts:
#           - localhost:27017
#
#
# More installation and setup notes are on https://docs.mongodb.org/ecosystem/tutorial/mongoid-installation/

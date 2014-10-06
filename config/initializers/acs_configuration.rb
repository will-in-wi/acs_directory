# Be sure to restart your server when you modify this file.

Rails.application.config.acs_config = YAML.load_file("#{::Rails.root}/config/acs_configuration.yml")
Rails.application.config.acs_credentials = YAML.load_file("#{::Rails.root}/config/acs_authentication.yml")[::Rails.env]

AccessACS API Church Directory
==============================

This is a simple church directory, built to sync with the AccessACS API.

Set-up instructions
-------------------

These instructions are designed to set up a site for developer usage. It
is assumed that the user can adapt these instructions for a production
launch as needed.

Prerequisites:
* Ruby (2.1 is tested. RBENV is recommended on Posix systems.)
* Bundler (`gem install bundler`)

# Check out the repository from GitHub.
# Run `bundle install`
# Copy `config/acs_configuration.yml.example` to `config/acs_configuration.yml`. Modify as needed.
# Copy `config/acs_authentication.yml.example` to `config/acs_authentication.yml`. Modify as needed. Do not change the `test` section.
# Download data from AccessACS by running `bundle exec rake acs:bulk_update`.
# Start Webbrick. `rails server`

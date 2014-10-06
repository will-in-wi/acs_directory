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

1. Check out the repository from GitHub.
2. Run `bundle install`
3. Copy `config/acs_configuration.yml.example` to `config/acs_configuration.yml`. Modify as needed.
4. Copy `config/acs_authentication.yml.example` to `config/acs_authentication.yml`. Modify as needed. Do not change the `test` section.
5. Download data from AccessACS by running `bundle exec rake acs:bulk_update`.
6. Start Webbrick. `rails server`

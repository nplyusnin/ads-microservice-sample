# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'puma'
gem 'rake'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'
gem 'rack-ougai'
gem 'rack-request-id'
gem 'amazing_print'

gem 'config'
gem 'i18n'

gem 'pg'
gem 'sequel'

gem 'dry-initializer'
gem 'dry-validation'

gem 'activesupport'
gem 'fast_jsonapi'

gem 'httparty'

group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'database_cleaner-sequel'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'rspec'
end

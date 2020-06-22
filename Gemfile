source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.0'
gem 'active_model_serializers', '~> 0.10.0'
gem 'rails', '~> 5.2.3'
gem 'sqlite3'
gem 'puma', '~> 3.12'
gem 'rswag'
gem 'versionist'
gem 'will_paginate', '~> 3.1.0'

gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'pry'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'pry-nav'
end

group :test do
  gem 'faker'
end

gem 'simplecov', require: false, group: :test

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
  gem 'rubocop-rails', require: false
end

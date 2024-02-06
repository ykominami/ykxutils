# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ykxutils.gemspec
gemspec

gem "bundler"
gem "erubi"
gem "rake", "~> 13.1"
gem "tilt"

group :development do
  gem "debug"
  gem "yard"
end

group :test do
  gem "rspec", "~> 3.12"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
end

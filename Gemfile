# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ykxutils.gemspec
gemspec

gem "bundler"
gem "erubi"
gem "rake", "~> 13.2"
gem "tilt"
gem "rubyXL"

group :development do
  gem "loggerx"
  gem "debug"
  gem "yard"
end

group :development, :test do
  gem "rspec", "~> 3.13"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
end

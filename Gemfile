# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ykxutils.gemspec
gemspec

gem "rake", "~> 13.0"

group :development do
  gem "yard"
end

group :test, optional: true do
  gem "rspec", "~> 3.0"
  gem "rubocop", "~> 1.21"
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
end

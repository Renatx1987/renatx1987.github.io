source "https://rubygems.org"

ruby "~> 3.3.0"

# Rails framework
gem "rails", "~> 8.1"

# The modern asset pipeline for Rails
gem "propshaft"

# Use the Puma web server
gem "puma", ">= 5.0"

# Hotwire's SPA-like page accelerator
gem "turbo-rails"

# Hotwire's modest JavaScript framework
gem "stimulus-rails"

# Build JSON APIs with ease
gem "jbuilder"

# Use SQLite for development
gem "sqlite3", ">= 2.1"

# Reduces boot times through caching
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

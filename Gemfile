source 'https://rubygems.org'

gem 'rails', '3.2.18'

group :production do
  gem 'pg'
  gem 'unicorn'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'omniauth'
gem 'omniauth-google-apps'

gem 'less-rails-bootstrap'

group :development do
  gem 'debugger'
  gem 'sqlite3'
  gem 'thin'
end

group :test do
  gem 'mocha', :require => false
end

gem 'json'
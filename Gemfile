source 'https://rubygems.org'

gem 'bundler'
gem 'dry-auto_inject'
gem 'dry-container'
gem 'hanami', '~> 0.9'
gem 'hanami-model'
gem 'lyv', git: 'https://github.com/igneus/lyv.git'
gem 'pg'
gem 'rake'
gem 'rugged' # git bindings
gem 'slim' # templating

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end

source 'https://rubygems.org'

gem 'bundler'
gem 'hanami', git: 'git@github.com:hanami/hanami.git'
gem 'hanami-model', '~> 0.7'
gem 'lyv', git: 'https://github.com/igneus/lyv.git'
gem 'pg'
gem 'rake'
gem 'rugged' # git bindings

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

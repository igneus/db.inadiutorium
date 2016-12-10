require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/db.inadiutorium'
require_relative '../apps/web/application'

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/db.inadiutorium_development.sqlite3'
    #    adapter :sql, 'postgres://localhost/db.inadiutorium_development'
    #    adapter :sql, 'mysql://localhost/db.inadiutorium_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/db.inadiutorium/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery do
      development :test
      test        :test
      # production :smtp, address: ENV['SMTP_PORT'], port: 1025
    end
  end
end

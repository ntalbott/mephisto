set :client, "talbott"
set :application, "blog"
set :user, client

set :deploy_to, "/var/www/#{client}/#{application}"
set :domain, "talbott.ws"

role :web, domain
role :app, domain
role :db,  domain, :primary => true


set :client, "spreedly"
set :application, "blog"
set :user, client

set :deploy_to, "/var/www/#{client}/#{application}"
set :domain, "blog.spreedly.com"

role :web, domain
role :app, domain
role :db,  domain, :primary => true


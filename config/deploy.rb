require 'mongrel_cluster/recipes'

set :client, "talbott"
set :application, "blog"

set :deploy_to, "/var/www/#{client}/#{application}"
set :domain, "#{application}.#{client}.dock.terralien.biz"

set :user, client
set :repository, "https://terralien.devguard.com/svn/general/talbott.ws/blog/"
set :svn_username, "ntalbott"
set :rails_env, "production"
set :use_sudo, false
set :mongrel_conf, proc{"/etc/mongrel_cluster/#{client}_#{application}.yml"}

role :web, domain
role :app, domain
role :db,  domain, :primary => true

task :after_symlink do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "mkdir -p #{release_path}/tmp"
  run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  run "ln -nfs #{shared_path}/themes/site-1 #{release_path}/themes/site-1"
end
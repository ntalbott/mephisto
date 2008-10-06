require 'spacesuit/recipes/terralien'

set :deploy_to, "/var/www/#{client}/#{application}"
set :domain, "talbott.ws"
set :keep_releases, 10
default_run_options[:pty] = true

role :web, domain
role :app, domain
role :db,  domain, :primary => true

after "deploy:symlink" do
  run %(ln -nfs #{shared_path}/assets #{release_path}/public/assets)
  run "ln -nfs #{shared_path}/themes/site-1 #{release_path}/themes/site-1"
end

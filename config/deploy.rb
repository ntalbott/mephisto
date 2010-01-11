set :default_stage, "production"

require 'capistrano/ext/multistage'
require 'spacesuit/recipes/common'
require 'spacesuit/recipes/terralien'

set :rails_env, "production"
 
set :scm, "git"
set :repository, "git@github.com:ntalbott/mephisto.git"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :ssh_options, {:forward_agent => true}
set :keep_releases, 10
default_run_options[:pty] = true

after "deploy:symlink" do
  run %(ln -nfs #{shared_path}/assets #{release_path}/public/assets)
  run "ln -nfs #{shared_path}/themes #{release_path}/themes"
end

before "deploy:update_code", "deploy:git:pending"


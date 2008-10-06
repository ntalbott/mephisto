set :default_stage, "production"

require 'capistrano/ext/multistage'
require 'spacesuit/recipes/common'

set :client, "talbott"
set :application, "blog"
set :user, client
set :rails_env, "production"
 
set :scm, "git"
set :repository, "git@github.com:ntalbott/mephisto.git"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :ssh_options, {:forward_agent => true}

before "deploy:update_code", "deploy:git:pending"

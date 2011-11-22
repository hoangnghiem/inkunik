require 'erb'
# RVM bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2-p0'
set :rvm_type, :user
set :use_sudo, true

set :stages, %w(dev staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

default_run_options[:pty]   = true # must be set for the password prompt from git to work
#ssh_options[:forward_agent] = true # use local keys instead of the ones on the server

set :application, "inkunik.com"
set :repository, "git@git.assembla.com:inkunik.git"

set :scm, :git
set :user, "inkunik"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm_verbose, true

role :web, "inkunik.com"                          # Your HTTP server, Apache/etc
role :app, "inkunik.com"                          # This may be the same as your `Web` server
role :db,  "inkunik.com", :primary => true # This is where Rails migrations will run

require "bundler/capistrano"

#after "deploy:update_code", "db:yaml", "db:symlink"
after "deploy:update", "rake:bootstrap_db"

namespace :deploy do
  task :start do ; end
  task :stop  do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, "tmp/restart.txt")}"
  end

  #task :symlink, :except => { :no_release => true } do
    #run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  #end
end

namespace :rake do
  task :bootstrap_db, :roles => :app do
    run "cd #{release_path}; rake RAILS_ENV=#{rails_env} -f #{release_path}/Rakefile db:drop db:migrate db:seed --trace"
  end
end

namespace :db do
  desc "Create database yaml in shared path" 
  task :yaml do
    db_config = ERB.new <<-EOF
    base: &base
      adapter: sqlite3
      database: db/development.sqlite3
      pool: 5
      timeout: 5000

    development:
      database: db/development.sqlite3
      <<: *base

    staging:
      database: db/staging.sqlite3
      <<: *base

    test:
      database: db/test.sqlite3
      <<: *base

    production:
      database: db/production.sqlite3
      <<: *base
    EOF

    run "mkdir -p #{shared_path}/config" 
    put db_config.result, "#{shared_path}/config/database.yml" 
  end

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end
end

#database mysql
#adapter: mysql2
#encoding: utf8
#pool: 10
#socket: /var/run/mysqld/mysqld.sock
#username: inkunik
#password: 
#host: inkunik.com
#port: 3306


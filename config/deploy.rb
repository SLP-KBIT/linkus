# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'linkus'
set :repo_url, 'https://github.com/SLP-KBIT/linkus.git'

set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :linked_files, fetch(:linked_files, []).push('.env')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')
set :keep_releases, 5

set :deploy_to, '/home/rails/deploy/linkus'
set :conditionally_migrate, true
set :deploy_via, :remote_cache

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :restart
end

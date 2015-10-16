set :stage, :production
set :branch, 'master'
set :rails_env, 'production'
set :migration_role, 'db'

set :deploy_to, '/home/app/UnivWare/linkus'
server 'c0', user: ENV['PRODUCTION_USER'], roles: %w(web app db)

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: true,
  auth_methods: %w(publickey)
}
